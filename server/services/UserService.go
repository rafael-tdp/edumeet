package services

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/repositories"
	"edumeet/utils"
	"errors"
	"log"
)

type UserService struct {
	userRepo *repositories.UserRepository
}

func NewUserService(userRepo *repositories.UserRepository) *UserService {
	return &UserService{
		userRepo: userRepo,
	}
}

func (us *UserService) GetUser(userID string) (*dtos.UserDTO, error) {
	user, err := us.userRepo.FindByID(userID)
	if err != nil {
		return nil, errors.New("user not found in service")
	}
	return user, nil
}

func (us *UserService) RegisterUser(registerDTO dtos.RegisterDTO) (*ent.User, error) {

	bcryptUtils := utils.Bcrypt{}

	hashedPassword := bcryptUtils.HashPassword(registerDTO.Password)

	user, err := us.userRepo.CreateUser(registerDTO, hashedPassword)
	if err != nil {
		log.Printf("Error saving user to database: %v", err)
		return nil, err
	}
	return user, nil
}

func (us *UserService) ValidateUser(ctx context.Context, code string) (*ent.User, error) {

	user, err := us.userRepo.ValidateUserByCode(ctx, code)
	if err != nil {
		return nil, err
	}

	return user, nil
}
