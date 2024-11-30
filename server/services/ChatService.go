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
	events   map[string]*Event
	mu       sync.Mutex
}

func NewChatService(chatRepo *repositories.ChatRepository) *ChatService {
	return &ChatService{
		chatRepo: chatRepo,
		events:   make(map[string]*Event),
	}
}

func (cs *ChatService) SubscribeToEvent(eventID, userID string, ch chan string) {
	cs.mu.Lock()
	defer cs.mu.Unlock() // Assurez-vous que le verrou est libéré dès que possible

	event, exists := cs.events[eventID]
	if !exists {
		event = &Event{
			ID:        eventID,
			Listeners: make(map[string]chan string),
		}
		cs.events[eventID] = event
	}

	// Ajoutez l'utilisateur et son canal au bon événement
	event.mu.Lock()
	defer event.mu.Unlock()

	event.Listeners[userID] = ch
}

func (cs *ChatService) BroadcastMessage(ctx context.Context, messageDTO dtos.MessageDTO, eventID string, userID string) (*dtos.ResponseMessageDTO, error) {
	cs.mu.Lock()
	event, exists := cs.events[eventID]
	cs.mu.Unlock()

	if !exists {
		return nil, fmt.Errorf("event %s not found", eventID)
	}

	message, err := cs.chatRepo.CreateMessage(ctx, messageDTO, eventID, userID)
	if err != nil {
		fmt.Printf("Error creating message: %v\n", err)
		return nil, err
	}

	// Envoie de messages à tous les utilisateurs du bon événement
	event.mu.Lock()
	defer event.mu.Unlock()

	// TODO : remplacer par la liste des documents
	documents := []string{}

	responseMessage := dtos.EntToResponseMessageDTO(message, documents, "CREATE", userID)

	for userID, ch := range event.Listeners {
		select {
		case ch <- utils.JSONStringify(responseMessage):
			fmt.Printf("Message sent to %s in event %s\n", userID, eventID)
		default:
			fmt.Printf("Unable to send message to %s in event %s\n", userID, eventID)
		}
	}
	return responseMessage, nil
}

func (cs *ChatService) CheckUserHasPermission(participants []dtos.ParticipantDTO, userID string) bool {
	_, foundParticipant := lo.Find(participants, func(p dtos.ParticipantDTO) bool {
		return p.UserID == userID && p.Status == "ACCEPTED"
	})
	return foundParticipant
}

//delete message

func (cs *ChatService) DeleteMessage(eventID, messageID, userID string) (*dtos.DeleteMessageDTO, error) {

	cs.mu.Lock()
	event, exists := cs.events[eventID]
	cs.mu.Unlock()

	if !exists {
		return nil, fmt.Errorf("event %s not found", eventID)
	}

	err := cs.chatRepo.DeleteMessage(messageID)
	if err != nil {
		fmt.Printf("Error deleting message: %v\n", err)
		return nil, err
	}
	// Envoie de messages à tous les utilisateurs du bon événement
	event.mu.Lock()
	defer event.mu.Unlock()

	deleteMessageDTO := dtos.EntToDeleteMessageDTO(messageID, "DELETE", userID)

	for userID, ch := range event.Listeners {
		select {
		case ch <- utils.JSONStringify(deleteMessageDTO):
			fmt.Printf("Message sent to %s in event %s\n", userID, eventID)
		default:
			fmt.Printf("Unable to send message to %s in event %s\n", userID, eventID)
		}
	}

	return deleteMessageDTO, nil
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
