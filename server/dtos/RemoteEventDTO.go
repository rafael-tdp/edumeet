package dtos

import "edumeet/ent"

type RemoteEventDTO struct {
	URL string `json:"url"`
}

func EntToRemoteEventDTO(remoteEvent *ent.RemoteEvent) *RemoteEventDTO {
	return &RemoteEventDTO{
		URL: remoteEvent.URL,
	}
}
