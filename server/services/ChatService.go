package services

import (
	"context"
	"edumeet/dtos"
	"edumeet/repositories"
	"edumeet/utils"
	"fmt"
	"sync"

	"github.com/samber/lo"
)

type Event struct {
	ID        string
	Listeners map[string]chan string
	mu        sync.Mutex
}

type ChatService struct {
	chatRepo *repositories.ChatRepository
	users    map[string]chan string // Connexions utilisateurs
	mu       sync.Mutex
}

func NewChatService(chatRepo *repositories.ChatRepository) *ChatService {
	return &ChatService{
		chatRepo: chatRepo,
		users:    make(map[string]chan string),
	}
}

func (cs *ChatService) SubscribeUser(userID string, ch chan string) {
	cs.mu.Lock()
	defer cs.mu.Unlock()
	cs.users[userID] = ch
}

func (cs *ChatService) UnsubscribeUser(userID string) {
	cs.mu.Lock()
	defer cs.mu.Unlock()
	delete(cs.users, userID)
}

func (cs *ChatService) GetChat(messageID string) (*dtos.GetChatDTO, error) {
	message, err := cs.chatRepo.GetChat(messageID)
	if err != nil {
		return nil, err
	}

	return dtos.EntToGetChatDTO(message.Edges.Event.ID, message.Content, message.ID, message.CreatedAt.String(), message.Edges.User.ID, []string{}), nil
}

func (cs *ChatService) CheckUserHasPermission(participants []dtos.ParticipantDTO, userID string) bool {
	_, foundParticipant := lo.Find(participants, func(p dtos.ParticipantDTO) bool {
		return p.UserID == userID && p.Status == "ACCEPTED"
	})
	return foundParticipant
}

func (cs *ChatService) GetChats(eventID string) ([]*dtos.GetChatDTO, error) {
	chats, err := cs.chatRepo.GetChatsByEventID(eventID)
	if err != nil {
		return nil, err
	}

	var getChatDtos []*dtos.GetChatDTO
	for _, chat := range chats {
		getChatDtos = append(getChatDtos, dtos.EntToGetChatDTO(eventID, chat.Content, chat.ID, chat.CreatedAt.String(), chat.Edges.User.ID, []string{}))
	}

	return getChatDtos, nil
}

func (cs *ChatService) SendMessageToUser(userID string, message string) error {
	cs.mu.Lock()
	defer cs.mu.Unlock()

	ch, exists := cs.users[userID]
	if !exists {
		fmt.Printf("User %s not connected. Skipping message delivery.\n", userID)
		return nil
	}

	select {
	case ch <- message:
		fmt.Printf("Message sent to user %s\n", userID)
	default:
		fmt.Printf("Failed to send message to user %s\n", userID)
	}

	return nil
}

func (cs *ChatService) SendMessageToEvent(ctx context.Context, eventID string, participants []dtos.ParticipantDTO, message string, userId string, username string) error {
	// Create message for event
	messageCreated, err := cs.chatRepo.CreateMessage(ctx, message, eventID, userId)
	if err != nil {
		fmt.Printf("Error creating message: %v\n", err)
		return err
	}

	messageResponse := dtos.CreateMessageEventDTO{
		Type:         "CREATE",
		Username:     username,
		MessageId:    messageCreated.ID,
		EventId:      eventID,
		CreationDate: messageCreated.CreatedAt.String(),
		Content:      message,
	}

	// Send message to all active participants except the sender
	for _, participant := range participants {
		if participant.Status == "ACCEPTED" && participant.UserID != userId {
			userID := participant.UserID
			_ = cs.SendMessageToUser(userID, utils.JSONStringify(messageResponse))
		}
	}
	return nil
}

func (cs *ChatService) DeleteMessage(eventID, messageID, userID string, participants []dtos.ParticipantDTO) (*dtos.DeleteMessageDTO, error) {
	// Supprimez le message de la base de données
	err := cs.chatRepo.DeleteMessage(messageID)
	if err != nil {
		fmt.Printf("Error deleting message: %v\n", err)
		return nil, err
	}

	// Construisez l'objet de notification pour les participants
	deleteMessageDTO := dtos.EntToDeleteMessageDTO(messageID, "DELETE", userID)

	deleteMessage := dtos.DeleteMessageEventDTO{
		Type:      "DELETE",
		MessageId: messageID,
		EventId:   eventID,
	}

	// Envoyer la notification aux participants connectés
	for _, participant := range participants {
		if participant.Status == "ACCEPTED" && participant.UserID != userID {
			_ = cs.SendMessageToUser(participant.UserID, utils.JSONStringify(deleteMessage))
		}
	}

	return deleteMessageDTO, nil
}
