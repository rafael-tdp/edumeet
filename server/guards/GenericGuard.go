package guards

import (
	"edumeet/ent"
	"edumeet/interfaces"
)

func CanAuthorize(user *ent.User, entity interfaces.Authorizable) bool {
	return user.Role == "admin" || user.ID == *entity.GetCreatedBy()
}

func IsAdmin(user *ent.User) bool {
	return user.Role == "admin"
}
