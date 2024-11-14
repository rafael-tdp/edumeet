package dtos

import "edumeet/ent"

type RemoteEventDTO struct {
	ID  string `json:"id"`
	URL string `json:"url"`
}

func EntToRemoteEventDTO(remoteEvent *ent.RemoteEvent) *RemoteEventDTO {
	return &RemoteEventDTO{
		ID:  remoteEvent.ID,
		URL: remoteEvent.URL,
	}
}
