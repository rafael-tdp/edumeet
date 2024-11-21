package repositories

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/ent/user"
	"edumeet/utils"
	"errors"
)

type UserRepository struct {
	client *ent.Client
}

func NewUserRepository(client *ent.Client) *UserRepository {
	return &UserRepository{
		client: client,
	}
}

func (ur *UserRepository) GetById(userID string) (*ent.User, error) {

	user, err := ur.client.User.Query().Where(user.IDEQ(userID)).Only(context.Background())
	if err != nil {
		return nil, errors.New("user not found")
	}

	return user, nil
}

func (ur *UserRepository) CreateUser(ctx context.Context, registerDTO dtos.RegisterDTO, hashedPassword string) (*ent.User, error) {
	lat, lng, err := utils.GetLatLng(registerDTO.Address)

	if err != nil {
		return nil, err
	}

	user, err := ur.client.User.
		Create().
		SetEmail(registerDTO.Email).
		SetUsername(registerDTO.Username).
		SetLastname(registerDTO.Lastname).
		SetFirstname(registerDTO.Firstname).
		SetPassword(hashedPassword).
		SetBirthDate(registerDTO.BirthDate).
		//SetNillableBio(registerDTO.Bio).
		//SetNillablePicture(registerDTO.Picture).
		SetActivated(false).
		SetLat(lat).
		SetLng(lng).
		Save(ctx)

	if err != nil {
		return nil, err
	}

	return user, nil
}

func (ur *UserRepository) ValidateUser(userId string) (*ent.User, error) {

	u, err := ur.client.User.
		Query().
		Where(user.IDEQ(userId)).
		Only(context.Background())
	if err != nil {
		return nil, err
	}

	_, err = u.Update().
		SetActivated(true).
		Save(context.Background())
	if err != nil {
		return nil, errors.New("failed to update user")
	}

	return u, nil
}

func (ur *UserRepository) GetByEmail(email string) (*ent.User, error) {
	u, err := ur.client.User.Query().Where(user.Email(email)).Only(context.Background())
	if err != nil {
		return nil, err
	}
	return u, nil
}

func (ur *UserRepository) UpdatePassword(userID string, hashedPassword string) error {
	_, err := ur.client.User.Update().
		Where(user.IDEQ(userID)).
		SetPassword(hashedPassword).
		Save(context.Background())
	if err != nil {
		return err
	}
	return nil
}
