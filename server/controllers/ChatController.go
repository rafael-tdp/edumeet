package controllers

import (
	"bufio"
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/guards"
	"edumeet/services"
	"fmt"
	"net/http"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/oklog/ulid/v2"
	"github.com/sirupsen/logrus"
	"github.com/valyala/fasthttp"
)

type ChatController struct {
	chatService  *services.ChatService
	eventService *services.EventService
}

func NewChatController(chatService *services.ChatService, eventService *services.EventService) *ChatController {
	return &ChatController{
		chatService:  chatService,
		eventService: eventService,
	}
}

// @Summary Connect to the chat
// @Description Establish a connection to receive real-time chat messages
// @Tags Chat
// @Accept json
// @Produce json
// @Success 200 {string} string "Connection established"
// @Failure 400 {object} map[string]string "Bad Request: Failed to connect"
// @Router /chats/connect [get]
// map pour suivre les connexions SSE actives par utilisateur
var activeConnections = make(map[string]chan string)

func (cc *ChatController) Connect(c *fiber.Ctx) error {
	user := c.Locals("user").(*ent.User)

	// Créer un nouveau canal pour la nouvelle connexion
	messageChannel := make(chan string)
	if !cc.chatService.IsUserSubscribed(user.ID) {
		cc.chatService.SubscribeUser(user.ID, messageChannel)
		activeConnections[user.ID] = messageChannel
	}

	// Définir les en-têtes HTTP pour SSE
	c.Set("Content-Type", "text/event-stream")
	c.Set("Cache-Control", "no-cache")
	c.Set("Connection", "keep-alive")
	c.Set("Transfer-Encoding", "chunked")

	// Définir le stream de sortie pour l'utilisateur
	c.Status(fiber.StatusOK).Context().SetBodyStreamWriter(fasthttp.StreamWriter(func(w *bufio.Writer) {
		ticker := time.NewTicker(3 * time.Second) // Période de ping
		defer func() {
			ticker.Stop()
			cc.chatService.UnsubscribeUser(user.ID)
		}()

		for {
			select {
			case message := <-messageChannel:
				msg := fmt.Sprintf("data: %s\n\n", message)
				if _, err := fmt.Fprintf(w, msg); err != nil {
					logrus.Errorf("Error writing message for user %s: %v\n", user.ID, err)
					return
				}

			case <-ticker.C:
				ping := "event: ping\ndata: {}\n\n"
				if _, err := fmt.Fprintf(w, ping); err != nil {
					logrus.Warnf("Ping failed for user %s: %v\n", user.ID, err)
					return
				}

				if err := w.Flush(); err != nil {
					logrus.Errorf("Error flushing ping for user %s: %v\n", user.ID, err)
					return
				}
			}
		}
	}))

	return nil
}

// @Summary Send message to a friend
// @Description Send a message to a specific friend by their ID
// @Tags Chat
// @Accept json
// @Produce json
// @Param friendId path string true "Friend's ID"
// @Param message body dtos.MessageDTO true "Message to send"
// @Success 200 {object} map[string]string "Message sent successfully"
// @Failure 400 {object} map[string]string "Bad Request: Invalid message format"
// @Failure 404 {object} map[string]string "Not Found: Friend not found"
// @Failure 500 {object} map[string]string "Internal Server Error: Failed to send message"
// @Router /chats/send-message-to-friend/{friendId} [post]
func (cc *ChatController) SendMessageToFriend(c *fiber.Ctx) error {
	friendId := c.Params("friendId")
	currentUser := c.Locals("user").(*ent.User)

	var messageDTO dtos.MessageDTO

	if err := c.BodyParser(&messageDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	ctx := context.WithValue(c.Context(), "user_id", currentUser.ID)
	if err := cc.chatService.SendMessageToFriend(ctx, messageDTO.Message, friendId, currentUser.ID, currentUser.Username); err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{"message": "Message sent successfully"})
}

// @Summary Send message to an event
// @Description Send a message to all participants of an event
// @Tags Chat
// @Accept json
// @Produce json
// @Param eventId path string true "Event's ID"
// @Param message body dtos.MessageDTO true "Message to send"
// @Success 200 {object} map[string]string "Message sent to event successfully"
// @Failure 400 {object} map[string]string "Bad Request: Invalid message format"
// @Failure 404 {object} map[string]string "Not Found: Event not found"
// @Failure 500 {object} map[string]string "Internal Server Error: Failed to send message"
// @Router /chats/send-message-to-event/{eventId} [post]
func (cc *ChatController) SendMessageToEvent(c *fiber.Ctx) error {

	eventId := c.Params("eventId")

	var messageDTO dtos.MessageDTO

	if err := c.BodyParser(&messageDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	user := c.Locals("user").(*ent.User)

	// Vérifiez si l'événement existe
	event, err := cc.eventService.GetEvent(eventId)
	if err != nil {
		return c.Status(http.StatusNotFound).JSON(fiber.Map{"error": "Event not found"})
	}

	if !cc.chatService.CheckUserHasPermission(event.Participants, user.ID) {
		return c.Status(http.StatusForbidden).JSON(fiber.Map{"error": "You don't have permission to access this event"})
	}

	// Envoyez le message à tous les utilisateurs de cet événement
	ctx := context.WithValue(c.Context(), "user_id", user.ID)
	err = cc.chatService.SendMessageToEvent(ctx, eventId, event.Participants, messageDTO.Message, user.ID, user.Username, *user.Picture)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{"message": "Message sent to event successfully"})
}

// @Summary Delete a message in an event
// @Description Delete a specific message in an event by message ID
// @Tags Chat
// @Accept json
// @Produce json
// @Param eventId path string true "Event's ID"
// @Param messageId path string true "Message's ID"
// @Success 200 {object} map[string]string "Message deleted successfully"
// @Failure 400 {object} map[string]string "Bad Request: Invalid ID"
// @Failure 404 {object} map[string]string "Not Found: Message or Event not found"
// @Failure 403 {object} map[string]string "Forbidden: Not authorized"
// @Failure 500 {object} map[string]string "Internal Server Error: Failed to delete message"
// @Router /chats/delete-message-to-event/{eventId}/{messageId} [delete]
func (cc *ChatController) DeleteMessageEvent(c *fiber.Ctx) error {
	user := c.Locals("user").(*ent.User)

	messageID, err := ulid.Parse(c.Params("messageId"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	eventID, err := ulid.Parse(c.Params("eventId"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	// Vérifiez si l'event existe
	event, errEvent := cc.eventService.GetEvent(eventID.String())
	if errEvent != nil {
		return c.Status(http.StatusNotFound).JSON(fiber.Map{

			"error": "Event not found",
		})
	}

	// Vérifiez si le message existe
	msg, errMessage := cc.chatService.GetChat(messageID.String())
	if errMessage != nil {
		return c.Status(http.StatusNotFound).JSON(fiber.Map{
			"error": "Message not found",
		})
	}

	if !guards.CanAuthorize(user, msg) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}

	if !cc.chatService.CheckUserHasPermission(event.Participants, user.ID) {
		return c.Status(http.StatusForbidden).JSON(fiber.Map{
			"error": "You don't have permission to access this event",
		})
	}

	deleteMessage, err := cc.chatService.DeleteMessage(eventID.String(), messageID.String(), user.ID, event.Participants)

	if err != nil {
		return c.Status(http.StatusInternalServerError).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	return c.JSON(deleteMessage)
}

// @Summary Delete a message to a friend
// @Description Delete a specific message in a chat with a friend
// @Tags Chat
// @Accept json
// @Produce json
// @Param friendId path string true "Friend's ID"
// @Param messageId path string true "Message's ID"
// @Success 204 {object} map[string]string "Message deleted successfully"
// @Failure 400 {object} map[string]string "Bad Request: Invalid ID"
// @Failure 404 {object} map[string]string "Not Found: Message or Friend not found"
// @Failure 403 {object} map[string]string "Forbidden: Not authorized"
// @Failure 500 {object} map[string]string "Internal Server Error: Failed to delete message"
// @Router /chats/delete-message-to-friend/{friendId}/{messageId} [delete]
func (cc *ChatController) DeleteMessageFriend(c *fiber.Ctx) error {
	user := c.Locals("user").(*ent.User)

	friendId, err := ulid.Parse(c.Params("friendId"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid Friend ID"})
	}

	messageID, err := ulid.Parse(c.Params("messageId"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	// Vérifiez si le message existe
	msg, errMessage := cc.chatService.GetChat(messageID.String())
	if errMessage != nil {
		return c.Status(http.StatusNotFound).JSON(fiber.Map{
			"error": "Message not found",
		})
	}

	if !guards.CanAuthorize(user, msg) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}

	errDelete := cc.chatService.DeleteMessageFriend(messageID.String(), user.ID, friendId.String())

	if errDelete != nil {
		return c.Status(http.StatusInternalServerError).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	return c.Status(fiber.StatusNoContent).JSON(fiber.Map{})
}

// @Summary Get conversations of the user
// @Description Get all conversations for the authenticated user
// @Tags Chat
// @Accept json
// @Produce json
// @Success 200 {array} dtos.ConversationDTO "List of conversations"
// @Failure 500 {object} map[string]string "Internal Server Error: Failed to retrieve conversations"
// @Router /chats/conversations [get]
func (cc *ChatController) GetConversations(c *fiber.Ctx) error {
	user := c.Locals("user").(*ent.User)

	conversationDTOs, err := cc.chatService.GetConversations(user.ID)
	if err != nil {
		return c.Status(http.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}

	return c.JSON(conversationDTOs)
}

// @Summary Get messages from a friend
// @Description Get all messages between the user and a specific friend
// @Tags Chat
// @Accept json
// @Produce json
// @Param friendId path string true "Friend's ID"
// @Success 200 {array} dtos.MessageDTO "List of messages"
// @Failure 400 {object} map[string]string "Bad Request: Failed to retrieve messages"
// @Failure 404 {object} map[string]string "Not Found: Friend not found"
// @Router /chats/get-conversation-friend/{friendId} [get]
func (cc *ChatController) GetMessagesFriend(c *fiber.Ctx) error {
	user := c.Locals("user").(*ent.User)

	friendId := c.Params("friendId")

	messages, err := cc.chatService.GetMessagesFriend(user.ID, friendId)
	if err != nil {
		return c.Status(http.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.JSON(messages)
}

// @Summary Get messages from an event
// @Description Get all messages related to a specific event
// @Tags Chat
// @Accept json
// @Produce json
// @Param eventId path string true "Event's ID"
// @Success 200 {array} dtos.MessageDTO "List of messages"
// @Failure 400 {object} map[string]string "Bad Request: Failed to retrieve messages"
// @Failure 404 {object} map[string]string "Not Found: Event not found"
// @Failure 403 {object} map[string]string "Forbidden: Not authorized"
// @Router /chats/get-conversation-event/{eventId} [get]
func (cc *ChatController) GetMessagesEvent(c *fiber.Ctx) error {
	user := c.Locals("user").(*ent.User)

	eventId := c.Params("eventId")

	event, err := cc.eventService.GetEvent(eventId)
	if err != nil {
		return c.Status(http.StatusNotFound).JSON(fiber.Map{"error": "Event not found"})
	}

	if !cc.chatService.CheckUserHasPermission(event.Participants, user.ID) {
		return c.Status(http.StatusForbidden).JSON(fiber.Map{"error": "You don't have permission to access this event"})
	}

	messages, err := cc.chatService.GetMessagesEvent(user.ID, eventId)
	if err != nil {
		return c.Status(http.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.JSON(messages)
}

// @Summary Disconnect from the chat
// @Description Close the connection to stop receiving real-time chat messages
// @Tags Chat
// @Accept json
// @Produce json
// @Success 200 {string} string "Connection closed"
// @Failure 400 {object} map[string]string "Bad Request: Failed to disconnect"
// @Router /chats/disconnect [get]
func (cc *ChatController) Disconnect(c *fiber.Ctx) error {
	user := c.Locals("user").(*ent.User)
	if existingChannel, exists := activeConnections[user.ID]; exists {
		cc.chatService.UnsubscribeUser(user.ID)
		close(existingChannel)
		<-existingChannel
	}
	return nil
}
