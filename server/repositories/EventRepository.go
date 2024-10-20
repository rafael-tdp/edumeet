package repositories

import "edumeet/ent"

type EventRepository struct {
	client *ent.Client
}

func NewEventRepository(client *ent.Client) *EventRepository {
	return &EventRepository{
		client: client,
	}
}
