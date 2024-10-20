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

	userDTO, err := dtos.ParseUserDTO(user)
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

	userProfileDTO, err := dtos.ParseUserProfileDTO(user)

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

	bcryptUtils := utils.Bcrypt{}

	hashedPassword := bcryptUtils.HashPassword(registerDTO.Password)

	user, err := us.userRepo.CreateUser(registerDTO, hashedPassword)
	if err != nil {
		log.Printf("Error saving user to database: %v", err)
		return nil, err
	}
	return user, nil
}

func (us *UserService) ValidateUser(code string) (*ent.User, error) {

	user, err := us.userRepo.ValidateUserByCode(code)
	if err != nil {
		return nil, err
	}

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

	updatedUser, err := user.Update().SetCode(code).Save(context.Background())

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

	userDTO := dtos.UserDTO{
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
		Role:      user.Role,
	}

	return userDTO, nil
}

func (us *UserService) ResetPassword(code string, requestBody dtos.ResetPasswordDTO) error {
	user, err := us.userRepo.VerifyUserByCode(code)
	if err != nil {
		return err
	}
	bcryptUtil := utils.Bcrypt{}
	passwordHashed := bcryptUtil.HashPassword(requestBody.PlainPassword)

	_, err = user.Update().SetPassword(passwordHashed).SetCode("").Save(context.Background())

	if err != nil {
		return err
	}

	return nil
}
