package enums

type ParticipantStatus string

const (
	ParticipantAccepted ParticipantStatus = "ACCEPTED"
	ParticipantPending  ParticipantStatus = "PENDING"
	ParticipantRejected ParticipantStatus = "REJECTED"
)
