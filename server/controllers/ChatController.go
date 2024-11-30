package controllers

import (
	"bufio"
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/services"
	"fmt"
	"net/http"

	"github.com/go-playground/validator/v10"
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

func (cc *ChatController) ConnectToEvent(c *fiber.Ctx) error {
	user := c.Locals("user").(*ent.User)

	eventID, err := ulid.Parse(c.Params("event_id"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	// Vérifiez si l'event existe
	event, err := cc.eventService.GetEvent(eventID.String())
	if err != nil {
		return c.Status(http.StatusNotFound).JSON(fiber.Map{

			"error": "Event not found",
		})
	}

	// Vérifiez si l'utilisateur est autorisé à accéder à l'événement
	if !cc.chatService.CheckUserHasPermission(event.Participants, user.ID) {
		return c.Status(http.StatusForbidden).JSON(fiber.Map{
			"error": "You don't have permission to access this event",
		})
	}

	c.Set("Content-Type", "text/event-stream")
	c.Set("Cache-Control", "no-cache")
	c.Set("Connection", "keep-alive")
	c.Set("Transfer-Encoding", "chunked")

	messageChannel := make(chan string)
	cc.chatService.SubscribeToEvent(eventID.String(), user.ID, messageChannel)

	c.Status(fiber.StatusOK).Context().SetBodyStreamWriter(fasthttp.StreamWriter(func(w *bufio.Writer) {

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

func (cc *ChatController) SendMessage(c *fiber.Ctx) error {

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

	// Vérifiez si l'utilisateur est autorisé à accéder à l'événement
	if !cc.chatService.CheckUserHasPermission(event.Participants, user.ID) {
		return c.Status(http.StatusForbidden).JSON(fiber.Map{
			"error": "You don't have permission to access this event",
		})
	}

	var messageDTO dtos.MessageDTO

	if err := c.BodyParser(&messageDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	validations := validator.New()
	errValidations := validations.Struct(messageDTO)
	if errValidations != nil {
		errors := make([]string, 0)
		for _, err := range err.(validator.ValidationErrors) {
			errors = append(errors, err.Error())
		}
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{"error": errors})
	}

	ctx := context.WithValue(c.Context(), "user_id", user.ID)

	responseMessage, err := cc.chatService.BroadcastMessage(ctx, messageDTO, eventID.String(), user.ID)
	if err != nil {
		return c.Status(http.StatusInternalServerError).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	return c.JSON(responseMessage)
}

func (cc *ChatController) DeleteMessage(c *fiber.Ctx) error {
	user := c.Locals("user").(*ent.User)

	messageID, err := ulid.Parse(c.Params("message_id"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

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

	deleteMessage, err := cc.chatService.DeleteMessage(eventID.String(), messageID.String(), user.ID)
	if err != nil {
		return c.Status(http.StatusInternalServerError).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	return c.JSON(deleteMessage)
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
