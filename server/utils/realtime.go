package utils

import (
	"edumeet/structures"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strings"
	"sync"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/gorilla/websocket"
)

// Structure pour le client
type Client struct {
	conn     *websocket.Conn
	eventID  string
	sendChan chan []byte
	userID   string
	expTime  int64
}

// Structure de l'événement
type Event struct {
	ID      string
	Clients map[*Client]bool
	mu      sync.Mutex
}

// Structure du Hub
type Hub struct {
	Events map[string]*Event
	mu     sync.Mutex
}

var hub = Hub{Events: make(map[string]*Event)}

// Définir l'upgrader WebSocket
var upgrader = websocket.Upgrader{
	CheckOrigin: func(r *http.Request) bool {
		return true // Autorise toutes les connexions
	},
}

// Fonction pour gérer la connexion WebSocket avec `net/http` pour l'upgrade
func HandleConnection(w http.ResponseWriter, r *http.Request) {
	// Récupérer le token JWT du header Authorization
	authHeader := r.Header.Get("Authorization")
	if authHeader == "" {
		http.Error(w, "Missing Authorization Header", http.StatusUnauthorized)
		return
	}

	tokenString := strings.TrimPrefix(authHeader, "Bearer ")
	if tokenString == authHeader {
		http.Error(w, "Invalid Authorization header format", http.StatusUnauthorized)
		return
	}

	// Définir les claims pour récupérer l'user_id et expTime
	claims := &structures.Claims{} // Assurez-vous d'avoir une structure Claims pour gérer le JWT

	// Clé secrète pour vérifier le token, remplacez par la clé de votre projet
	jwtKey := []byte("EMN4IqiFZ4")

	fmt.Println("Token:", tokenString)

	// Parser et valider le token
	token, err := jwt.ParseWithClaims(tokenString, claims, func(token *jwt.Token) (interface{}, error) {
		// Vérifier que la méthode de signature est correcte
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
		}
		return jwtKey, nil
	})

	if err != nil {
		log.Println("Erreur lors du parsing du JWT:", err)
		http.Error(w, fmt.Sprintf("Token parsing error: %s", err.Error()), http.StatusUnauthorized)
		return
	}

	if !token.Valid {
		http.Error(w, "Invalid token", http.StatusUnauthorized)
		return
	}

	// Vérifier l'expiration du token
	if claims.ExpiresAt != nil && claims.ExpiresAt.Time.Before(time.Now()) {
		http.Error(w, "JWT expired", http.StatusUnauthorized)
		return
	}

	// Récupérer le user_id depuis le token
	userID := claims.UserID // Supposons que l'user_id est dans "sub", sinon ajustez cette ligne
	log.Printf("User ID: %s", userID)

	// Récupérer l'expiration depuis le token
	expTime := claims.ExpiresAt.Time.Unix() // Récupérer l'expiration comme timestamp Unix
	log.Printf("Token Expiration: %d", expTime)

	// Utiliser le Upgrader pour convertir la connexion HTTP en WebSocket
	upgrader := websocket.Upgrader{
		CheckOrigin: func(r *http.Request) bool {
			return true // Accepter toutes les connexions
		},
	}

	// Effectuer l'upgrade de la connexion HTTP en WebSocket
	conn, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Println("Erreur lors de l'upgrade WebSocket:", err)
		http.Error(w, "WebSocket Upgrade Error", http.StatusInternalServerError)
		return
	}
	defer conn.Close()

	// Créer un client WebSocket
	client := &Client{
		conn:     conn,
		sendChan: make(chan []byte, 10),
		userID:   userID,  // Utiliser l'userID extrait du JWT
		expTime:  expTime, // Passer le temps d'expiration
	}

	// Récupérer l'eventID depuis les paramètres de la requête
	eventID := r.URL.Query().Get("event")
	if eventID == "" {
		log.Println("Aucun événement spécifié")
		http.Error(w, "Missing event ID", http.StatusBadRequest)
		return
	}

	// Ajouter le client à l'événement
	client.eventID = eventID
	hub.mu.Lock()
	event, exists := hub.Events[eventID]
	if !exists {
		event = &Event{
			ID:      eventID,
			Clients: make(map[*Client]bool),
		}
		hub.Events[eventID] = event
	}
	event.mu.Lock()
	event.Clients[client] = true
	event.mu.Unlock()
	hub.mu.Unlock()

	// Utiliser un WaitGroup pour gérer les goroutines
	var wg sync.WaitGroup
	wg.Add(2)

	// Goroutine pour envoyer des messages
	go func() {
		defer wg.Done()
		HandleMessages(client)
	}()

	// Goroutine pour gérer les messages entrants
	go func() {
		defer wg.Done()
		HandleIncomingMessages(client)
	}()

	wg.Wait()
}

// Fonction pour gérer les messages entrants
func HandleIncomingMessages(client *Client) {
	for {
		_, msg, err := client.conn.ReadMessage()
		if err != nil {
			log.Println("Erreur de lecture du message:", err)
			hub.mu.Lock()
			event, exists := hub.Events[client.eventID]
			if exists {
				event.mu.Lock()
				delete(event.Clients, client)
				event.mu.Unlock()
			}
			hub.mu.Unlock()
			break
		}

		// Créer la réponse sous forme de JSON avec le content et user_id
		response := map[string]interface{}{
			"content": "Retour du msg: " + string(msg), // Votre logique pour le message retourné
			"user_id": client.userID,
		}

		// Convertir la réponse en JSON
		respJSON, _ := json.Marshal(response)
		SendMessageToEvent(client, respJSON)
	}
}

// Fonction pour envoyer un message à tous les clients abonnés à l'événement
func SendMessageToEvent(client *Client, msg []byte) {
	hub.mu.Lock()
	defer hub.mu.Unlock()

	event, exists := hub.Events[client.eventID]
	if !exists {
		return
	}

	event.mu.Lock()
	for c := range event.Clients {
		if c != client {
			select {
			case c.sendChan <- msg:
			default:
				close(c.sendChan)
			}
		}
	}
	event.mu.Unlock()
}

// Fonction pour gérer l'envoi des messages
func HandleMessages(client *Client) {
	for msg := range client.sendChan {
		err := client.conn.WriteMessage(websocket.TextMessage, msg)
		if err != nil {
			log.Println("Erreur d'envoi du message:", err)
			return
		}
	}
}
