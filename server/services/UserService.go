package services

import (
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

func (us *UserService) ValidateUser(requestBody dtos.ValidateUserDTO) (bool, error) {
	user, err := us.userRepo.GetByEmail(requestBody.Email)
	if err != nil {
		return false, err
	}

	if user.Activated == false {
		code := utils.GetValidationCodeFromRedis(user.ID)
		if code != requestBody.Code {
			return false, errors.New("invalid code")
		} else {
			_, err = us.userRepo.ValidateUser(user.ID)
			if err != nil {
				return false, err
			}
			utils.DeleteValidationCodeFromRedis(user.ID)
		}
	} else {
		return false, errors.New("user already activated")
	}

	return true, nil
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

func (us *UserService) ForgotPassword(requestBody dtos.ForgotPasswordDTO) (*ent.User, string, error) {
	user, err := us.userRepo.GetByEmail(requestBody.Email)
	if err != nil {
		return nil, "", err
	}

	if user.Activated == false {
		return nil, "", errors.New("user not activated")
	}

	ulidUtils := utils.ULID{}
	code := ulidUtils.GenerateUlid()()

	utils.StoreValidationCodeInRedis(user.ID, code)

	return user, code, nil
}

func (us *UserService) Verify(requestBody dtos.VerifyCodeDTO) (dtos.UserDTO, error) {
	user, err := us.userRepo.GetByEmail(requestBody.Email)
	if err != nil {
		return dtos.UserDTO{}, errors.New("user not found")
	}

	code := utils.GetValidationCodeFromRedis(user.ID)
	if code != requestBody.Code {
		return dtos.UserDTO{}, errors.New("invalid code")
	}

	user, err = us.userRepo.ValidateUser(user.ID)
	if err != nil {
		return dtos.UserDTO{}, err
	}

	userDTO, err := dtos.UserEntToDto(user)
	if err != nil {
		return dtos.UserDTO{}, err
	}

	return *userDTO, nil
}

func (us *UserService) ResetPassword(requestBody dtos.ResetPasswordDTO) error {
	user, err := us.userRepo.GetByEmail(requestBody.Email)
	if err != nil {
		return errors.New("user not found")
	}

	if user.Activated == false {
		return errors.New("user not activated")
	}

	code := utils.GetValidationCodeFromRedis(user.ID)
	if code != requestBody.Code {
		return errors.New("invalid code")
	}

	bcryptUtils := utils.Bcrypt{}
	hashedPassword := bcryptUtils.HashPassword(requestBody.Password)

	err = us.userRepo.UpdatePassword(user.ID, hashedPassword)
	if err != nil {
		return err
	}

	utils.DeleteValidationCodeFromRedis(user.ID)
	return nil
}
