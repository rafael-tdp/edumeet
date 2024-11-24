package services

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/repositories"
	"edumeet/utils"
	"errors"
)

type AuthService struct {
	userRepo *repositories.UserRepository
}

func NewAuthService(userRepo *repositories.UserRepository) *AuthService {
	return &AuthService{
		userRepo: userRepo,
	}
}

func (as *AuthService) Login(requestBody dtos.LoginDTO) (string, error) {
	user, err := as.userRepo.GetByEmail(requestBody.Email)
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

func (as *AuthService) RegisterUser(ctx context.Context, registerDTO dtos.RegisterDTO) (*ent.User, error) {
	existingUser, err := as.userRepo.GetByEmail(registerDTO.Email)
	if err == nil && existingUser != nil {
		return nil, errors.New("Cet email est déjà utilisé")
	}
	bcryptUtils := utils.Bcrypt{}
	hashedPassword := bcryptUtils.HashPassword(registerDTO.Password)
	user, err := as.userRepo.CreateUser(ctx, registerDTO, hashedPassword)
	if err != nil {
		return nil, err
	}
	return user, nil
}

func (as *AuthService) ForgotPassword(requestBody dtos.ForgotPasswordDTO) (*ent.User, string, error) {
	user, err := as.userRepo.GetByEmail(requestBody.Email)
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

func (as *AuthService) ResetPassword(requestBody dtos.ResetPasswordDTO) error {
	user, err := as.userRepo.GetByEmail(requestBody.Email)
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
	err = as.userRepo.UpdatePassword(user.ID, hashedPassword)
	if err != nil {
		return err
	}
	utils.DeleteValidationCodeFromRedis(user.ID)
	return nil
}
