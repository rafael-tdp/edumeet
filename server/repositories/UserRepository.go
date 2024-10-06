package repositories

import (
	"context"
	"edumeet/ent"
	"edumeet/ent/user"
	"edumeet/models"
	"errors"
)

type UserRepository struct {
	client *ent.Client
}

// NewUserRepository crée une nouvelle instance de UserRepository
func NewUserRepository(client *ent.Client) *UserRepository {
	return &UserRepository{
		client: client,
	}
}

// FindByID recherche un utilisateur dans la base de données par ID
func (ur *UserRepository) FindByID(userID string) (*models.User, error) {

	user, err := ur.client.User.Query().Where(user.IDEQ(userID)).Only(context.Background())
	if err != nil {
		return nil, errors.New("user not found")
	}

	return &models.User{
		ID:        user.ID,
		Email:     user.Email,
		Username:  user.Username,
		Lastname:  user.Lastname,
		Firstname: user.Firstname,
		BirthDate: user.BirthDate,
		Bio:       user.Bio,
		Picture:   user.Picture,
		Activated: user.Activated,
		ReportNum: user.ReportNumber,
		Lng:       user.Lng,
		Lat:       user.Lat,
	}, nil
}
