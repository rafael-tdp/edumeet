package guards

import (
	"edumeet/ent"
	"edumeet/interfaces"
)

const (
	RoleAdmin = "ADMIN"
)

func CanAuthorize(user *ent.User, entity interfaces.Authorizable) bool {
	return user.Role == RoleAdmin || user.ID == *entity.GetCreatedBy()
}

func IsAdmin(user *ent.User) bool {
	return user.Role == RoleAdmin
}
