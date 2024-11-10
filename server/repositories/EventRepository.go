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

func (er *EventRepository) CreateRemoteEvent(remoteEvent *ent.RemoteEvent) (*ent.RemoteEvent, error) {
	createdRemoteEvent, err := er.client.RemoteEvent.Create().
		SetTitle(remoteEvent.Title).
		SetDescription(remoteEvent.Description).
		SetStartDate(remoteEvent.StartDate).
		SetEndDate(remoteEvent.EndDate).
		SetHost(remoteEvent.Host).
		Save(er.client.Ctx)

	if err != nil {
		return nil, err
	}

	return createdRemoteEvent, nil
}
