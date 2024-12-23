package services

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/repositories"
	"edumeet/utils"
	"errors"
	"fmt"
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

func (us *UserService) Verify(ctx context.Context, requestBody dtos.VerifyCodeDTO) (dtos.UserDTO, error) {
	user, err := us.userRepo.GetByEmail(requestBody.Email)
	if err != nil {
		return dtos.UserDTO{}, errors.New("user not found")
	}
	code := utils.GetValidationCodeFromRedis(user.ID)
	if code != requestBody.Code {
		return dtos.UserDTO{}, errors.New("invalid code")
	}
	user, err = us.userRepo.ValidateUser(ctx, user.ID)
	if err != nil {
		return dtos.UserDTO{}, err
	}
	userDTO, err := dtos.UserEntToDto(user)
	if err != nil {
		return dtos.UserDTO{}, err
	}
	return *userDTO, nil
}

func (us *UserService) ValidateUser(ctx context.Context, requestBody dtos.ValidateUserDTO) (bool, error) {
	user, err := us.userRepo.GetByEmail(requestBody.Email)
	if err != nil {
		return false, err
	}

	if user.Activated == false {
		code := utils.GetValidationCodeFromRedis(user.ID)
		if code != requestBody.Code {
			return false, errors.New("invalid code")
		} else {
			_, err = us.userRepo.ValidateUser(ctx, user.ID)
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

func (us *UserService) UpdateUser(ctx context.Context, userID string, updateUserDTO dtos.UpdateUserDTO) (*ent.User, error) {
	_, err := us.userRepo.GetById(userID)
	if err != nil {
		return nil, errors.New("user not found")
	}

	updatedUser, err := us.userRepo.UpdateUser(ctx, userID, updateUserDTO)
	if err != nil {
		return nil, err
	}

	return updatedUser, nil
}

func (us *UserService) GetUserSubjects(userID string) ([]dtos.SubjectDTO, error) {
	subjects, err := us.userRepo.GetUserSubjecs(userID)

	if err != nil {
		return nil, err
	}

	subjectsDTO := make([]dtos.SubjectDTO, 0)
	for _, subject := range subjects {
		subjectDTO := dtos.SubjectEntToDTO(subject)
		subjectsDTO = append(subjectsDTO, *subjectDTO)
	}

	return subjectsDTO, nil
}

func (us *UserService) UpdateUserSubjects(ctx context.Context, userID string, subjects []string) error {
	_, err := us.userRepo.GetById(userID)
	if err != nil {
		return errors.New("user not found")
	}

	_, err = us.userRepo.UpdateUserSubjects(ctx, userID, subjects)
	if err != nil {
		return err
	}

	return nil
}
