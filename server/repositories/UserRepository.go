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

func (ur *UserRepository) FindByID(userID string) (*dtos.UserDTO, error) {

	user, err := ur.client.User.Query().Where(user.IDEQ(userID)).Only(context.Background())
	if err != nil {
		return nil, errors.New("user not found")
	}

	return &dtos.UserDTO{
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

func (ur *UserRepository) ValidateUserByCode(ctx context.Context, code string) (*ent.User, error) {

	u, err := ur.client.User.
		Query().
		Where(user.CodeEQ(code)).
		Only(ctx)
	if err != nil {
		return nil, errors.New("user not found")
	}

	updatedUser, err := u.Update().
		SetActivated(true).
		Save(ctx)
	if err != nil {
		return nil, errors.New("failed to update user")
	}

	return updatedUser, nil
}

func (ur *UserRepository) FindUserByEmail(ctx context.Context, email string) (*ent.User, error) {
	u, err := ur.client.User.Query().Where(user.Email(email)).Only(ctx)
	if err != nil {
		return nil, err
	}
	return u, nil
}
