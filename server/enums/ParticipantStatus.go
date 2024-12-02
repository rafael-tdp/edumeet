package enums

type ParticipantStatus string

const (
	ParticipantAccepted ParticipantStatus = "accepted"
	ParticipantPending  ParticipantStatus = "pending"
	ParticipantRejected ParticipantStatus = "rejected"
)
