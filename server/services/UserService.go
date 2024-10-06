package services

import (
	"edumeet/dtos"
	"edumeet/repositories"
	"errors"
)

// UserService contient la logique métier liée aux utilisateurs
type UserService struct {
	userRepo *repositories.UserRepository
}

// NewUserService crée une nouvelle instance de UserService
func NewUserService(userRepo *repositories.UserRepository) *UserService {
	return &UserService{
		userRepo: userRepo,
	}
}

// GetUser récupère les informations d'un utilisateur par son ID
func (us *UserService) GetUser(userID string) (*dtos.UserDTO, error) {
	user, err := us.userRepo.FindByID(userID)
	if err != nil {
		return nil, errors.New("user not found in service")
	}
	return user, nil
}
