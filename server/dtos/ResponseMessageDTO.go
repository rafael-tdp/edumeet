package dtos

type ResponseMessageDTO struct {
	ID        string `json:"id"`
	Message   string `json:"message"`
	Username  string `json:"username"`
	CreatedBy string `json:"createdBy"`
	CreatedAt string `json:"createdAt"`
}

func EntToResponseMessageDTO(message string, id string, createdBy string, createdAt string, username string) ResponseMessageDTO {
	return ResponseMessageDTO{
		ID:        id,
		Message:   message,
		Username:  username,
		CreatedBy: createdBy,
		CreatedAt: createdAt,
	}
}
