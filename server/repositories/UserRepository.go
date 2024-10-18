package repositories

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/ent/user"
	"errors"

	"github.com/oklog/ulid/v2"
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

func (ur *UserRepository) CreateUser(registerDTO dtos.RegisterDTO, hashedPassword string) (*ent.User, error) {
	user, err := ur.client.User.
		Create().
		SetEmail(registerDTO.Email).
		SetUsername(registerDTO.Username).
		SetLastname(registerDTO.Lastname).
		SetFirstname(registerDTO.Firstname).
		SetPassword(hashedPassword).
		SetBirthDate(registerDTO.BirthDate).
		SetNillableBio(registerDTO.Bio).
		SetNillablePicture(registerDTO.Picture).
		SetActivated(false).
		SetCode(ulid.Make().String()).
		Save(context.Background())

	if err != nil {
		return nil, err
	}

	return user, nil
}

func (ur *UserRepository) ValidateUserByCode(code string) (*ent.User, error) {

	u, err := ur.VerifyUserByCode(code)

	if err != nil {
		return nil, err
	}

	updatedUser, err := u.Update().
		SetActivated(true).
		Save(context.Background())
	if err != nil {
		return nil, errors.New("failed to update user")
	}

	return updatedUser, nil
}

func (ur *UserRepository) GetByEmail(email string) (*ent.User, error) {
	u, err := ur.client.User.Query().Where(user.Email(email)).Only(context.Background())
	if err != nil {
		return nil, err
	}
	return u, nil
}

func (ur *UserRepository) VerifyUserByCode(code string) (*ent.User, error) {
	u, err := ur.client.User.
		Query().
		Where(user.CodeEQ(code)).
		Only(context.Background())

	if err != nil {
		return nil, errors.New("user not found")
	}

	return u, nil
}
