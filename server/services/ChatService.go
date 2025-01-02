package services

import (
	"context"
	"edumeet/dtos"
	"edumeet/enums"
	"edumeet/repositories"
	"edumeet/utils"
	"errors"
	"fmt"
	"log"
	"strings"
	"sync"

	"github.com/samber/lo"
	"github.com/sirupsen/logrus"
)

type Event struct {
	ID        string
	Listeners map[string]chan string
	mu        sync.Mutex
}

type ChatService struct {
	chatRepo              *repositories.ChatRepository
	userRepository        *repositories.UserRepository
	participantRepository *repositories.ParticipantRepository
	users                 map[string]chan string // Connexions utilisateurs
	mu                    sync.Mutex
}

func NewChatService(chatRepo *repositories.ChatRepository, userRepository *repositories.UserRepository, participantRepository *repositories.ParticipantRepository) *ChatService {
	return &ChatService{
		chatRepo:              chatRepo,
		userRepository:        userRepository,
		participantRepository: participantRepository,
		users:                 make(map[string]chan string),
	}
}

func (cs *ChatService) SubscribeUser(userID string, ch chan string) {
	cs.mu.Lock()
	defer cs.mu.Unlock()
	cs.users[userID] = ch
	logrus.Info("User ", userID, " subscribed")
	print("User ", userID, " subscribed\n")
}

func (cs *ChatService) UnsubscribeUser(userID string) {
	cs.mu.Lock()
	defer cs.mu.Unlock()
	delete(cs.users, userID)
	logrus.Info("User ", userID, " unsubscribed")
	print("User ", userID, " unsubscribed\n")
}

func (cs *ChatService) GetChat(messageID string) (*dtos.GetChatDTO, error) {
	message, err := cs.chatRepo.GetChat(messageID)
	if err != nil {
		logrus.Error("Error ChatService function GetChat: ", err)
		return nil, err
	}

	return dtos.EntToGetChatDTO(message.Content, message.ID, *message.CreatedBy), nil
}

func (cs *ChatService) CheckUserHasPermission(participants []dtos.ParticipantDTO, userID string) bool {
	_, foundParticipant := lo.Find(participants, func(p dtos.ParticipantDTO) bool {
		println(p.ID, p.UserID, userID)
		return p.UserID == userID && strings.EqualFold(p.Status, string(enums.ParticipantAccepted))
	})
	return foundParticipant
}

func (cs *ChatService) SendMessageToUser(userID string, message string) error {
	cs.mu.Lock()
	defer cs.mu.Unlock()

	ch, exists := cs.users[userID]
	if !exists {
		logrus.Warn("User ", userID, " not connected. Skipping message delivery.")
		fmt.Printf("User %s not connected. Skipping message delivery.\n", userID)
		return nil
	}

	select {
	case ch <- message:
		logrus.Info("Message sent to user ", userID)
		fmt.Printf("Message sent to user %s\n", userID)
	default:
		logrus.Warn("Failed to send message to user ", userID)
		fmt.Printf("Failed to send message to user %s\n", userID)
	}

	return nil
}

func (cs *ChatService) SendMessageToEvent(ctx context.Context, eventID string, participants []dtos.ParticipantDTO, message string, userId string, username string) error {
	// Create message for event
	messageCreated, err := cs.chatRepo.CreateMessage(ctx, message, eventID, userId)
	if err != nil {
		logrus.Error("Error ChatService function SendMessageToEvent: ", err)
		fmt.Printf("Error creating message: %v\n", err)
		return err
	}

	messageResponse := dtos.CreateMessageEventDTO{
		Type:         "CREATE",
		Username:     username,
		MessageId:    messageCreated.ID,
		EventId:      eventID,
		CreationDate: messageCreated.CreatedAt,
		Content:      message,
	}

	// Send message to all active participants except the sender
	for _, participant := range participants {
		if strings.ToUpper(participant.Status) == string(enums.ParticipantAccepted) && participant.UserID != userId {
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
		logrus.Error("Error ChatService function DeleteMessage: ", err)
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
		if participant.Status == string(enums.ParticipantAccepted) && participant.UserID != userID {
			_ = cs.SendMessageToUser(participant.UserID, utils.JSONStringify(deleteMessage))
		}
	}

	return deleteMessageDTO, nil
}

func (cs *ChatService) SendMessageToFriend(ctx context.Context, message, friendId string, userId string, username string) error {

	// Check if friendship exists between the two users
	friendship, err := cs.userRepository.GetFriendshipById(friendId)

	if friendship == nil {
		logrus.Warn("Vous ne pouvez pas envoyer de message à cet ami car vous n'êtes pas amis")
		return fmt.Errorf("Vous ne pouvez pas envoyer de message à cet ami car vous n'êtes pas amis")
	}

	if err != nil {
		logrus.Error("Error ChatService function SendMessageToFriend: ", err)
		fmt.Printf("Error getting friendship: %v\n", err)
	}

	if friendship.Status != string(enums.FriendAccepted) {
		return fmt.Errorf("Vous ne pouvez pas envoyer de message à cet ami car la demande d'ami n'a pas été acceptée")
	}

	if userId != friendship.Edges.User.ID && userId != friendship.Edges.Friend.ID {
		return fmt.Errorf("Vous n'êtes pas autorisé à envoyer un message à cet ami")
	}

	// Create message for friend
	messageCreated, err := cs.chatRepo.CreateMessageFriend(ctx, message, friendId, userId)
	if err != nil {
		logrus.Error("Error ChatService function SendMessageToFriend: ", err)
		fmt.Printf("Error creating message: %v\n", err)
		return err
	}

	var senderId string
	var receiverId string
	if userId == friendship.Edges.User.ID {
		senderId = friendship.Edges.User.ID
		receiverId = friendship.Edges.Friend.ID
	} else {
		senderId = friendship.Edges.Friend.ID
		receiverId = friendship.Edges.User.ID
	}

	messageResponse := dtos.CreateMessageFriendDTO{
		Type:         "CREATE",
		Username:     username,
		MessageId:    messageCreated.ID,
		SenderId:     senderId,
		ReceiverId:   receiverId,
		CreationDate: messageCreated.CreatedAt,
		Content:      message,
	}

	// Send message to friend
	_ = cs.SendMessageToUser(receiverId, utils.JSONStringify(messageResponse))

	return nil
}

func (cs *ChatService) DeleteMessageFriend(messageID, userID string, friendId string) error {

	// Check if friendship exists between the two users
	friendship, err := cs.userRepository.GetFriendshipById(friendId)

	if err != nil {
		logrus.Error("Error ChatService function DeleteMessageFriend: ", err)
		fmt.Printf("Error getting friendship: %v\n", err)
	}

	// Supprimez le message de la base de données
	errDelete := cs.chatRepo.DeleteMessage(messageID)
	if errDelete != nil {
		logrus.Error("Error ChatService function DeleteMessageFriend: ", err)
		fmt.Printf("Error deleting message: %v\n", err)
		return err
	}

	var senderId string
	var receiverId string

	if userID == friendship.Edges.User.ID {
		senderId = friendship.Edges.User.ID
		receiverId = friendship.Edges.Friend.ID
	} else {
		senderId = friendship.Edges.Friend.ID
		receiverId = friendship.Edges.User.ID
	}

	deleteMessage := dtos.DeleteMessageFriendDTO{
		Type:       "DELETE",
		MessageId:  messageID,
		FriendId:   friendId,
		SenderId:   senderId,
		ReceiverId: receiverId,
	}

	// Envoyer la notification aux participants connectés
	_ = cs.SendMessageToUser(senderId, utils.JSONStringify(deleteMessage))
	_ = cs.SendMessageToUser(receiverId, utils.JSONStringify(deleteMessage))

	return nil
}

func (cs *ChatService) GetConversations(userId string) ([]dtos.ConversationDTO, error) {
	var conversationDTOs []dtos.ConversationDTO

	conversationsFriends, err := cs.userRepository.GetFriendshipsByUserId(userId)

	if err != nil {
		logrus.Error("Error ChatService function GetConversations: ", err)
		return nil, err
	}

	conversationsEvents, err := cs.participantRepository.GetParticipationsUser(userId)

	if err != nil {
		logrus.Error("Error ChatService function GetConversations: ", err)
		return nil, err
	}

	for _, friendship := range conversationsFriends {
		var userNameFriend string
		if friendship.Edges.User.ID == userId {
			userNameFriend = friendship.Edges.Friend.Username
		} else {
			userNameFriend = friendship.Edges.User.Username
		}

		lastMessageFriend, err := cs.chatRepo.GetLastMessageFriend(friendship.ID)

		if err != nil {
			logrus.Error("Error ChatService function GetConversations: ", err)
			return nil, err
		}

		if lastMessageFriend != nil {
			conversationDTOs = append(conversationDTOs, dtos.EntToConversationDTO(friendship.ID, userNameFriend, "private", lastMessageFriend.Content, lastMessageFriend.CreatedAt.String(), lastMessageFriend.Edges.User.Username))
		}
	}

	for _, participant := range conversationsEvents {

		lastMessageEvent, err := cs.chatRepo.GetLastMessageEvent(participant.Edges.Event.ID)

		if err != nil {
			logrus.Error("Error ChatService function GetConversations: ", err)
			return nil, err
		}

		if lastMessageEvent != nil {
			conversationDTOs = append(conversationDTOs, dtos.EntToConversationDTO(participant.Edges.Event.ID, participant.Edges.Event.Title, "event", lastMessageEvent.Content, lastMessageEvent.CreatedAt.String(), lastMessageEvent.Edges.User.Username))
		}
	}

	return conversationDTOs, nil
}

func (cs *ChatService) GetMessagesFriend(userId, friendId string) ([]dtos.ResponseMessageDTO, error) {

	// Check if friendship exists between the two users
	friendship, err := cs.userRepository.GetFriendshipById(friendId)

	if err != nil {
		logrus.Error("Error ChatService function GetMessagesFriend: ", err)
		return nil, err
	}

	if userId != friendship.Edges.User.ID && userId != friendship.Edges.Friend.ID {
		return nil, errors.New("Vous n'êtes pas autorisé à voir les messages de cet ami")
	}

	if friendship.Status != string(enums.FriendAccepted) {
		return nil, errors.New("Vous ne pouvez pas voir les messages de cet ami car la demande d'ami n'a pas été acceptée")
	}

	messages, err := cs.chatRepo.GetMessagesFriend(friendId)
	if err != nil {
		logrus.Error("Error ChatService function GetMessagesFriend: ", err)
		return nil, err
	}

	getChatDtos := make([]dtos.ResponseMessageDTO, 0)
	for _, message := range messages {
		getChatDtos = append(getChatDtos, dtos.EntToResponseMessageDTO(message.Content, message.ID, *message.CreatedBy, message.CreatedAt.String(), message.Edges.User.Username))
	}

	return getChatDtos, nil
}

func (cs *ChatService) GetMessagesEvent(userId, eventId string) ([]dtos.ResponseMessageDTO, error) {

	messages, err := cs.chatRepo.GetMessagesEvent(eventId)
	if err != nil {
		logrus.Error("Error ChatService function GetMessagesEvent: ", err)
		return nil, err
	}

	getChatDtos := make([]dtos.ResponseMessageDTO, 0)
	for _, message := range messages {
		if message == nil {
			log.Println("message is nil")
			continue
		}

		if message.CreatedBy == nil {
			log.Println("message.CreatedBy is nil for message ID:", message.ID)
			continue
		}

		if message.Edges.User == nil {
			log.Println("Edges or User is nil for message ID:", message.ID)
			continue
		}

		getChatDtos = append(getChatDtos, dtos.EntToResponseMessageDTO(message.Content, message.ID, *message.CreatedBy, message.CreatedAt.String(), message.Edges.User.Username))
	}

	return getChatDtos, nil
}
