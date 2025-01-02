package services

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/repositories"
	"edumeet/utils"
	"errors"

	"github.com/sirupsen/logrus"
)

type AuthService struct {
	userRepo *repositories.UserRepository
}

func NewAuthService(userRepo *repositories.UserRepository) *AuthService {
	return &AuthService{
		userRepo: userRepo,
	}
}

func (as *AuthService) Login(requestBody dtos.LoginDTO) (string, dtos.UserDTO, error) {
	var user *ent.User
	var err error

	user, err = as.userRepo.GetByEmail(requestBody.Email)
	if err != nil {
		user, err = as.userRepo.GetByUsername(requestBody.Email)
		if err != nil {
			logrus.Error("Error AuthService function Login: ", err)
			return "", dtos.UserDTO{}, utils.ErrInvalidCredentials
		}
	}

	bcryptUtil := &utils.Bcrypt{}
	if !bcryptUtil.CheckPasswordHash(requestBody.Password, user.Password) {
		logrus.Warn("Error AuthService function Login: ", utils.ErrInvalidCredentials)
		return "", dtos.UserDTO{}, utils.ErrInvalidCredentials
	}

	if !user.Activated {
		logrus.Warn("Error AuthService function Login: ", utils.ErrAccountNotActivated)
		return "", dtos.UserDTO{}, utils.ErrAccountNotActivated
	}

	jwtToken, err := utils.GenerateJWT(user.Email, user.ID, user.Role)
	if err != nil {
		logrus.Error("Error AuthService function Login: ", err)
		return "", dtos.UserDTO{}, err
	}

	userDTO := dtos.UserDTO{
		ID:        user.ID,
		Email:     user.Email,
		Username:  user.Username,
		Firstname: user.Firstname,
		Lastname:  user.Lastname,
		Role:      user.Role,
		Activated: user.Activated,
		Address:   *user.Address,
		Bio:       user.Bio,
		Picture:   user.Picture,
		BirthDate: *user.BirthDate,
	}

	logrus.Info("AuthService function Login: ", jwtToken, userDTO)
	return jwtToken, userDTO, nil
}

func (as *AuthService) RegisterUser(ctx context.Context, registerDTO dtos.RegisterDTO) (*ent.User, error) {
	existingUser, err := as.userRepo.GetByEmail(registerDTO.Email)
	if err == nil && existingUser != nil {
		logrus.Warn("Error AuthService function RegisterUser: ", "Cet email est déjà utilisé")
		return nil, errors.New("Cet email est déjà utilisé")
	}
	existingUser, err = as.userRepo.GetByUsername(registerDTO.Username)
	if err == nil && existingUser != nil {
		logrus.Warn("Error AuthService function RegisterUser: ", "Ce nom d'utilisateur est déjà utilisé")
		return nil, errors.New("Ce nom d'utilisateur est déjà utilisé")
	}
	bcryptUtils := utils.Bcrypt{}
	hashedPassword := bcryptUtils.HashPassword(registerDTO.Password)
	user, err := as.userRepo.CreateUser(ctx, registerDTO, hashedPassword)
	if err != nil {
		logrus.Error("Error AuthService function RegisterUser: ", err)
		return nil, err
	}

	logrus.Info("AuthService function RegisterUser: ", user)
	return user, nil
}

func (as *AuthService) ForgotPassword(requestBody dtos.ForgotPasswordDTO) (*ent.User, string, error) {
	user, err := as.userRepo.GetByEmail(requestBody.Email)
	if err != nil {
		logrus.Error("Error AuthService function ForgotPassword: ", err)
		return nil, "", err
	}
	if user.Activated == false {
		logrus.Warn("Error AuthService function ForgotPassword: ", "user not activated")
		return nil, "", errors.New("user not activated")
	}
	ulidUtils := utils.ULID{}
	code := ulidUtils.GenerateUlid()()
	utils.StoreValidationCodeInRedis(user.ID, code)
	logrus.Info("AuthService function ForgotPassword: ", user, code)
	return user, code, nil
}

func (as *AuthService) ResetPassword(requestBody dtos.ResetPasswordDTO) error {
	user, err := as.userRepo.GetByEmail(requestBody.Email)
	if err != nil {
		logrus.Error("Error AuthService function ResetPassword: ", err)
		return errors.New("user not found")
	}
	if user.Activated == false {
		logrus.Warn("Error AuthService function ResetPassword: ", "user not activated")
		return errors.New("user not activated")
	}
	code := utils.GetValidationCodeFromRedis(user.ID)
	if code != requestBody.Code {
		logrus.Warn("Error AuthService function ResetPassword: ", "invalid code")
		return errors.New("invalid code")
	}
	bcryptUtils := utils.Bcrypt{}
	hashedPassword := bcryptUtils.HashPassword(requestBody.Password)
	err = as.userRepo.UpdatePassword(user.ID, hashedPassword)
	if err != nil {
		logrus.Error("Error AuthService function ResetPassword: ", err)
		return err
	}
	utils.DeleteValidationCodeFromRedis(user.ID)
	return nil
}
