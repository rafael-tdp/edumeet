package dtos

import "time"

type EventDTO struct {
	ID             string     `json:"id"`
	NbMaxUser      int        `json:"nb_max_user"`
	StartDate      time.Time  `json:"start_date"`
	EndDate        *time.Time `json:"end_date,omitempty"`
	IsPrivate      bool       `json:"is_private"`
	Title          string     `json:"title"`
	Description    *string    `json:"description,omitempty"`
	InvitationLink *string    `json:"invitation_link,omitempty"`
}
