package services

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/enums"
	"edumeet/firebase"
	"edumeet/repositories"
	"edumeet/utils"
	"errors"
	"fmt"

	"github.com/sirupsen/logrus"
)

type UserService struct {
	userRepo           *repositories.UserRepository
	documentRepository *repositories.DocumentRepository
}

func NewUserService(userRepo *repositories.UserRepository, documentRepository *repositories.DocumentRepository) *UserService {
	return &UserService{
		userRepo:           userRepo,
		documentRepository: documentRepository,
	}
}

func (us *UserService) GetUser(userID string) (*dtos.UserDTO, error) {
	user, err := us.userRepo.GetById(userID)
	if err != nil {
		logrus.Error("Error UserService GetUser: ", err)
		return nil, errors.New("user not found in service")
	}
	userDTO, err := dtos.UserEntToDto(user)
	if err != nil {
		logrus.Error("Error UserService GetUser: ", err)
		return nil, fmt.Errorf("error parsing user DTO: %w", err)
	}

	userFriendship, err := us.userRepo.GetFriendshipsByUserId(userID)
	if err != nil {
		logrus.Error("Error UserService GetUserProfile: ", err)
		return nil, err
	}

	participantRepository := repositories.NewParticipantRepository(us.userRepo.GetClient())
	participatedEvents, err := participantRepository.GetParticipationsUser(userID)
	if err != nil {
		logrus.Error("Error UserService GetUserProfile: ", err)
		return nil, err
	}

	userDTO.NbFriends = len(userFriendship)
	userDTO.NbParticipatedEvents = len(participatedEvents)

	return userDTO, nil
}

func (us *UserService) GetUserProfile(userID string) (*dtos.UserProfileDTO, error) {
	user, err := us.userRepo.GetById(userID)
	if err != nil {
		logrus.Error("Error UserService GetUserProfile: ", err)
		return nil, errors.New("user not found in service")
	}
	userProfileDTO, err := dtos.UserProfileEntToDto(user)
	if err != nil {
		logrus.Error("Error UserService GetUserProfile: ", err)
		return nil, fmt.Errorf("error parsing user profile DTO: %w", err)
	}

	userFriendship, err := us.userRepo.GetFriendshipsByUserId(userID)
	if err != nil {
		logrus.Error("Error UserService GetUserProfile: ", err)
		return nil, err
	}

	participantRepository := repositories.NewParticipantRepository(us.userRepo.GetClient())
	participatedEvents, err := participantRepository.GetParticipationsUser(userID)
	if err != nil {
		logrus.Error("Error UserService GetUserProfile: ", err)
		return nil, err
	}

	userProfileDTO.NbFriends = len(userFriendship)
	userProfileDTO.NbParticipatedEvents = len(participatedEvents)

	return userProfileDTO, nil
}

func (us *UserService) GetUserByEmail(email string) (*ent.User, error) {
	user, err := us.userRepo.GetByEmail(email)
	if err != nil {
		logrus.Error("Error UserService GetUserByEmail: ", err)
		return nil, errors.New("user not found in service")
	}
	return user, nil
}

func (us *UserService) Verify(ctx context.Context, requestBody dtos.VerifyCodeDTO) (dtos.UserDTO, error) {
	user, err := us.userRepo.GetByEmail(requestBody.Email)
	if err != nil {
		logrus.Error("Error UserService Verify: ", err)
		return dtos.UserDTO{}, errors.New("user not found")
	}
	code, err := utils.GetValidationCodeFromRedis(user.ID)
	if err != nil {
		logrus.Error("Error UserService Verify: ", err)
		return dtos.UserDTO{}, err
	}
	if code != requestBody.Code {
		logrus.Error("Error UserService Verify: ", err)
		return dtos.UserDTO{}, errors.New("invalid code")
	}
	user, err = us.userRepo.ValidateUser(ctx, user.ID)
	if err != nil {
		logrus.Error("Error UserService Verify: ", err)
		return dtos.UserDTO{}, err
	}
	userDTO, err := dtos.UserEntToDto(user)
	if err != nil {
		logrus.Error("Error UserService Verify: ", err)
		return dtos.UserDTO{}, err
	}
	return *userDTO, nil
}

func (us *UserService) ValidateUser(ctx context.Context, requestBody dtos.ValidateUserDTO) (bool, error) {
	user, err := us.userRepo.GetByEmail(requestBody.Email)
	if err != nil {
		logrus.Error("Error UserService ValidateUser: ", err)
		return false, err
	}

	if user.Activated == false {
		code, err := utils.GetValidationCodeFromRedis(user.ID)
		if err != nil {
			return false, err
		}

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
		logrus.Error("Error UserService UpdateUser: ", err)
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
		logrus.Error("Error UserService GetUserSubjects: ", err)
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
		logrus.Error("Error UserService UpdateUserSubjects: ", err)
		return errors.New("user not found")
	}

	_, err = us.userRepo.UpdateUserSubjects(ctx, userID, subjects)
	if err != nil {
		logrus.Error("Error UserService UpdateUserSubjects: ", err)
		return err
	}

	return nil
}

func (us *UserService) CreateFriendship(ctx context.Context, userID string, friendship dtos.CreateFriendshipDTO) (*ent.Friendship, error) {
	user, err := us.userRepo.GetById(userID)
	if err != nil {
		logrus.Error("Error UserService CreateFriendship: ", err)
		return nil, errors.New("user not found")
	}

	friend, err := us.userRepo.GetById(friendship.FriendID)
	if err != nil {
		logrus.Error("Error UserService CreateFriendship: ", err)
		return nil, errors.New("friend not found")
	}

	// Check if friendship already exists
	friendshipExists, err := us.userRepo.IsFriendshipExist(user.ID, friend.ID)
	if err != nil {
		logrus.Error("Error UserService CreateFriendship: ", err)
		return nil, err
	}

	if friendshipExists {
		logrus.Warn("Error UserService CreateFriendship: friendship already exists")
		return nil, errors.New("friendship already exists")
	}

	friendshipCreated, err := us.userRepo.CreateFriendship(ctx, user.ID, friend.ID)
	if err != nil {
		return nil, err
	}

	// Send notification to friend
	fcm_token, err := utils.GetTokenFromRedis(friend.ID + "_FCM")
	if err != nil {
		logrus.Error("Error UserService CreateFriendship: ", err)
		return nil, err
	}
	if fcm_token != "null" {
		firebase.SendNotification(fcm_token, "New friend request", user.Username+" wants to be your friend")
	}

	return friendshipCreated, nil
}

func (us *UserService) UpdateFriendship(friendshipID string, userId string) (*ent.Friendship, error) {
	friendship, err := us.userRepo.GetFriendshipById(friendshipID)
	if err != nil {
		logrus.Error("Error UserService UpdateFriendship: ", err)
		return nil, errors.New("friendship not found")
	}

	if friendship.Edges.Friend.ID != userId {
		logrus.Warn("Error UserService UpdateFriendship: user is not authorized to accept this friendship")
		return nil, errors.New("user is not authorized to accept this friendship")
	}

	updatedFriendship, err := us.userRepo.UpdateFriendship(friendship.ID)
	if err != nil {
		return nil, err
	}

	return updatedFriendship, nil
}

func (us *UserService) GetFriendships(userID string, status string) ([]dtos.FriendshipDTO, error) {

	if status == string(enums.FriendPending) {
		pendingFriendships, err := us.userRepo.GetPendingFriendships(userID)

		if err != nil {
			logrus.Error("Error UserService GetFriendships: ", err)
			return nil, err
		}

		pendingFriendshipsDTO, err := dtos.FriendshipsEntToDTO(pendingFriendships, userID, status)
		if err != nil {
			logrus.Error("Error UserService GetFriendships: ", err)
			return nil, err
		}

		return pendingFriendshipsDTO, nil
	} else if status == string(enums.FriendAccepted) {

		friendships, err := us.userRepo.GetFriendshipsByUserId(userID)
		if err != nil {
			logrus.Error("Error UserService GetFriendships: ", err)
			return nil, err
		}

		acceptedFriendshipDTO, err := dtos.FriendshipsEntToDTO(friendships, userID, status)
		if err != nil {
			logrus.Error("Error UserService GetFriendships: ", err)
			return nil, err
		}

		return acceptedFriendshipDTO, nil
	} else if status == string(enums.FriendAll) {

		pendingFriendships, err := us.userRepo.GetPendingFriendships(userID)
		if err != nil {
			logrus.Error("Error UserService GetFriendships: ", err)
			return nil, err
		}

		acceptedFriendships, err := us.userRepo.GetFriendshipsByUserId(userID)
		if err != nil {
			logrus.Error("Error UserService GetFriendships: ", err)
			return nil, err
		}

		friendships := append(pendingFriendships, acceptedFriendships...)
		friendshipsDTO, err := dtos.FriendshipsEntToDTO(friendships, userID, status)
		if err != nil {
			logrus.Error("Error UserService GetFriendships: ", err)
			return nil, err
		}

		return friendshipsDTO, nil
	} else {
		return nil, errors.New("invalid status")
	}
}

func (us *UserService) DeleteFriendship(friendshipID string, userId string) error {
	friendship, err := us.userRepo.GetFriendshipById(friendshipID)
	if err != nil {
		logrus.Error("Error UserService DeleteFriendship: ", err)
		return errors.New("friendship not found")
	}

	if userId != friendship.Edges.User.ID && userId != friendship.Edges.Friend.ID {
		return errors.New("user is not authorized to delete this friendship")
	}

	err = us.userRepo.DeleteFriendship(friendshipID)
	if err != nil {
		logrus.Error("Error UserService DeleteFriendship: ", err)
		return err
	}

	return nil
}

func (us *UserService) GetUsers() ([]dtos.GetUserAdmin, error) {
	users, err := us.userRepo.GetUsers()
	if err != nil {
		return nil, err
	}

	usersDTO := make([]dtos.GetUserAdmin, 0)
	for _, user := range users {
		userDTO, err := dtos.UserEntToDtoAdmin(user)
		if err != nil {
			return nil, err
		}
		usersDTO = append(usersDTO, *userDTO)
	}

	return usersDTO, nil
}

func (us *UserService) UpdateUserAdmin(ctx context.Context, updateUserDTO dtos.UpdateUserAdminDTO) (*dtos.GetUserAdmin, error) {
	_, err := us.userRepo.GetById(updateUserDTO.Id)
	if err != nil {
		return &dtos.GetUserAdmin{}, errors.New("user not found")
	}

	updatedUser, err := us.userRepo.UpdateUserAdmin(ctx, updateUserDTO)
	if err != nil {
		return &dtos.GetUserAdmin{}, err
	}

	dtosUser, err := dtos.UserEntToDtoAdmin(updatedUser)
	if err != nil {
		return &dtos.GetUserAdmin{}, err
	}

	return dtosUser, nil
}

func (us *UserService) CreateUserAdmin(ctx context.Context, createUserDTO dtos.CreateUserDTO) (*ent.User, error) {
	user, err := us.userRepo.GetByEmail(createUserDTO.Email)
	if err == nil {
		return nil, errors.New("user already exists")
	}

	bcryptUtils := utils.Bcrypt{}
	hashedPassword, err := bcryptUtils.HashPassword(createUserDTO.Password)
	if err != nil {
		return nil, err
	}

	user, err = us.userRepo.CreateUserAdmin(ctx, createUserDTO, hashedPassword)
	if err != nil {
		return nil, err
	}

	return user, nil
}

func (us *UserService) DeleteUser(ctx context.Context, userID string) error {
	_, err := us.userRepo.GetById(userID)
	if err != nil {
		return errors.New("user not found")
	}

	err = us.userRepo.SoftDeleteUser(ctx, userID)
	if err != nil {
		return err
	}

	return nil
}

func (us *UserService) LikeDocument(ctx context.Context, userID string, documentID string) error {
	_, err := us.userRepo.GetById(userID)
	if err != nil {
		return errors.New("user not found")
	}

	_, err = us.documentRepository.GetDocumentById(documentID)
	if err != nil {
		return errors.New("document not found")
	}

	us.userRepo.LikeDocument(ctx, userID, documentID)

	return nil
}

func (us *UserService) UnlikeDocument(ctx context.Context, userID string, documentID string) error {
	_, err := us.userRepo.GetById(userID)
	if err != nil {
		return errors.New("user not found")
	}

	_, err = us.documentRepository.GetDocumentById(documentID)
	if err != nil {
		return errors.New("document not found")
	}

	us.userRepo.UnlikeDocument(ctx, userID, documentID)

	return nil

}

func (us *UserService) GetLikedDocuments(userID string) ([]dtos.DocumentResponseDTO, error) {
	user, err := us.userRepo.GetById(userID)
	if err != nil {
		return nil, errors.New("user not found")
	}

	documentLiked := make([]dtos.DocumentResponseDTO, 0)

	for _, document := range user.Edges.DocumentsLikes {
		documentDTO := dtos.DocumentResponseDTO{
			ID:   document.ID,
			Path: document.Path,
			Name: document.Name,
		}
		documentLiked = append(documentLiked, documentDTO)

	}

	return documentLiked, nil
}
