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

	"github.com/gofiber/fiber/v2"
	"github.com/oklog/ulid/v2"
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

func (cc *ChatController) Connect(c *fiber.Ctx) error {
	user := c.Locals("user").(*ent.User)

	c.Set("Content-Type", "text/event-stream")
	c.Set("Cache-Control", "no-cache")
	c.Set("Connection", "keep-alive")
	c.Set("Transfer-Encoding", "chunked")

	messageChannel := make(chan string)
	cc.chatService.SubscribeUser(user.ID, messageChannel)

	c.Status(fiber.StatusOK).Context().SetBodyStreamWriter(fasthttp.StreamWriter(func(w *bufio.Writer) {
		defer cc.chatService.UnsubscribeUser(user.ID) // Nettoyage après déconnexion
		for {
			select {
			case message := <-messageChannel:
				msg := fmt.Sprintf("data: %s\n\n", message)
				fmt.Fprintf(w, msg)

				if err := w.Flush(); err != nil {
					fmt.Printf("Error flushing for user %s: %v\n", user.ID, err)
					return
				}
			}
		}
	}))

	return nil
}

func (cc *ChatController) GetChats(c *fiber.Ctx) error {
	user := c.Locals("user").(*ent.User)

	eventID, err := ulid.Parse(c.Params("event_id"))
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

	if !cc.chatService.CheckUserHasPermission(event.Participants, user.ID) {
		return c.Status(http.StatusForbidden).JSON(fiber.Map{
			"error": "You don't have permission to access this event",
		})
	}

	chats, err := cc.chatService.GetChats(eventID.String())
	if err != nil {
		return c.Status(http.StatusInternalServerError).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	return c.JSON(chats)
}

func (cc *ChatController) SendMessageToUser(c *fiber.Ctx) error {
	var payload struct {
		UserID  string `json:"user_id" validate:"required"`
		Message string `json:"message" validate:"required"`
	}

	if err := c.BodyParser(&payload); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	if err := cc.chatService.SendMessageToUser(payload.UserID, payload.Message); err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{"message": "Message sent successfully"})
}

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
	err = cc.chatService.SendMessageToEvent(ctx, eventId, event.Participants, messageDTO.Message, user.ID, user.Username)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{"message": "Message sent to event successfully"})
}

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
