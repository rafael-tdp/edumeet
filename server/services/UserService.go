package services

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/repositories"
	"edumeet/utils"
	"errors"
	"fmt"
	"log"
	"time"
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
	user, err := us.userRepo.GetById(userID)
	if err != nil {
		return nil, errors.New("user not found in service")
	}

	userDTO, err := dtos.UserEntToDto(user)
	if err != nil {
		return nil, fmt.Errorf("error parsing user DTO: %w", err)
	}

	return userDTO, nil
}

func (us *UserService) GetUserProfile(userID string) (*dtos.UserProfileDTO, error) {
	user, err := us.userRepo.GetById(userID)
	if err != nil {
		return nil, errors.New("user not found in service")
	}

	userProfileDTO, err := dtos.UserProfileEntToDto(user)

	if err != nil {
		return nil, fmt.Errorf("error parsing user profile DTO: %w", err)
	}

	return userProfileDTO, nil
}

func (us *UserService) GetUserByEmail(email string) (*ent.User, error) {
	user, err := us.userRepo.GetByEmail(email)
	if err != nil {
		return nil, errors.New("user not found in service")
	}
	return user, nil
}

func (us *UserService) RegisterUser(registerDTO dtos.RegisterDTO) (*ent.User, error) {

	existingUser, err := us.userRepo.GetByEmail(registerDTO.Email)
	if err == nil && existingUser != nil {
		return nil, errors.New("Cet email est déjà utilisé")
	}

	bcryptUtils := utils.Bcrypt{}

	hashedPassword := bcryptUtils.HashPassword(registerDTO.Password)

	user, err := us.userRepo.CreateUser(registerDTO, hashedPassword)
	if err != nil {
		log.Printf("Error saving user to database: %v", err)
		return nil, err
	}
	return user, nil
}

func (us *UserService) ValidateUser(requestBody dtos.VerifyCodeDTO) (*ent.User, error) {
	user, _ := us.userRepo.ValidateUserByCode(requestBody.Email, requestBody.Code)
	return user, nil
}

func (us *UserService) Login(requestBody dtos.LoginDTO) (string, error) {
	user, err := us.userRepo.GetByEmail(requestBody.Email)

	if err != nil {
		return "", utils.ErrInvalidCredentials
	}

	bcryptUtil := &utils.Bcrypt{}
	if !bcryptUtil.CheckPasswordHash(requestBody.Password, user.Password) {
		return "", utils.ErrInvalidCredentials
	}

	if !user.Activated {
		return "", utils.ErrAccountNotActivated
	}

	jwtToken, err := utils.GenerateJWT(user.Email, user.ID, user.Role)
	if err != nil {
		return "", err
	}

	return jwtToken, nil
}

func (us *UserService) ForgotPassword(requestBody dtos.ForgotPasswordDTO) (*ent.User, error) {
	user, err := us.userRepo.GetByEmail(requestBody.Email)
	if err != nil {
		return nil, err
	}

	ulidUtil := utils.ULID{}
	code := ulidUtil.GenerateUlid()()

	expirationTime := time.Now().Add(time.Minute * 30)

	updatedUser, err := user.Update().
		SetCode(code).
		SetCodeExpiration(expirationTime).
		Save(context.Background())

	if err != nil {
		return nil, err
	}

	return updatedUser, nil
}

func (us *UserService) Verify(code string) (dtos.UserDTO, error) {
	user, err := us.userRepo.VerifyUserByCode(code)
	if err != nil {
		return dtos.UserDTO{}, err
	}

	userDTO, err := dtos.UserEntToDto(user)

	if err != nil {
		return dtos.UserDTO{}, err
	}

	return *userDTO, nil
}

func (us *UserService) ResetPassword(code string, requestBody dtos.ResetPasswordDTO) error {
	user, err := us.userRepo.VerifyUserByCode(code)
	if err != nil {
		return err
	}

	if user.CodeExpiration == nil || user.CodeExpiration.Before(time.Now()) {
		return errors.New("code expired")
	}

	bcryptUtil := utils.Bcrypt{}
	passwordHashed := bcryptUtil.HashPassword(requestBody.PlainPassword)

	_, err = user.Update().
		SetPassword(passwordHashed).
		SetCode("").
		SetCodeExpiration(time.Time{}).
		Save(context.Background())

	if err != nil {
		return err
	}

	return nil
}
