package repositories

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/ent/friendship"
	"edumeet/ent/subject"
	"edumeet/ent/user"
	"edumeet/utils"
	"errors"
)

type UserRepository struct {
	client *ent.Client
}

func NewUserRepository(client *ent.Client) *UserRepository {
	return &UserRepository{
		client: client,
	}
}

func (ur *UserRepository) CreateUser(ctx context.Context, registerDTO dtos.RegisterDTO, hashedPassword string) (*ent.User, error) {
	lat, lng, err := utils.GetLatLng(registerDTO.Address)

	if err != nil {
		return nil, err
	}

	user, err := ur.client.User.
		Create().
		SetEmail(registerDTO.Email).
		SetUsername(registerDTO.Username).
		SetLastname(registerDTO.Lastname).
		SetFirstname(registerDTO.Firstname).
		SetPassword(hashedPassword).
		SetBirthDate(registerDTO.BirthDate).
		SetActivated(false).
		SetLat(lat).
		SetLng(lng).
		Save(ctx)

	if err != nil {
		return nil, err
	}

	return user, nil
}

func (ur *UserRepository) ValidateUser(ctx context.Context, userId string) (*ent.User, error) {

	u, err := ur.client.User.
		Query().
		Where(user.IDEQ(userId)).
		Only(ctx)
	if err != nil {
		return nil, err
	}

	_, err = u.Update().
		SetActivated(true).
		Save(ctx)
	if err != nil {
		return nil, errors.New("failed to update user")
	}

	return u, nil
}

func (ur *UserRepository) GetById(userID string) (*ent.User, error) {

	user, err := ur.client.User.Query().Where(user.IDEQ(userID)).Only(context.Background())
	if err != nil {
		return nil, errors.New("user not found")
	}

	return user, nil
}

func (ur *UserRepository) GetByEmail(email string) (*ent.User, error) {
	u, err := ur.client.User.Query().Where(user.Email(email)).Only(context.Background())
	if err != nil {
		return nil, err
	}
	return u, nil
}

func (ur *UserRepository) UpdatePassword(userID string, hashedPassword string) error {
	_, err := ur.client.User.Update().
		Where(user.IDEQ(userID)).
		SetPassword(hashedPassword).
		Save(context.Background())
	if err != nil {
		return err
	}
	return nil
}

func (ur *UserRepository) UpdateUser(ctx context.Context, userID string, updateUserDTO dtos.UpdateUserDTO) (*ent.User, error) {
	lat, lng, err := utils.GetLatLng(updateUserDTO.Address)
	if err != nil {
		return nil, err
	}

	user, err := ur.client.User.
		UpdateOneID(userID).
		SetEmail(updateUserDTO.Email).
		SetUsername(updateUserDTO.Username).
		SetFirstname(updateUserDTO.Firstname).
		SetLastname(updateUserDTO.Lastname).
		SetBirthDate(updateUserDTO.Birthdate).
		SetNillableBio(&updateUserDTO.Bio).
		SetNillablePicture(&updateUserDTO.Picture).
		//SetRole(updateUserDTO.Role).
		SetLng(lng).
		SetLat(lat).
		Save(ctx)

	if err != nil {
		return nil, err
	}

	return user, nil
}

func (ur *UserRepository) GetUserSubjecs(userID string) ([]*ent.Subject, error) {
	user, err := ur.client.User.Query().Where(user.IDEQ(userID)).WithSubjects().Only(context.Background())
	if err != nil {
		return nil, err
	}
	return user.Edges.Subjects, nil
}

func (ur *UserRepository) UpdateUserSubjects(ctx context.Context, userID string, subjectIDs []string) (*ent.User, error) {
	user, err := ur.client.User.Query().Where(user.IDEQ(userID)).WithSubjects().Only(ctx)
	if err != nil {
		return nil, err
	}

	_, err = user.Update().ClearSubjects().Save(ctx)
	if err != nil {
		return nil, err
	}

	for _, subjectID := range subjectIDs {
		subject, err := ur.client.Subject.Query().Where(subject.IDEQ(subjectID)).Only(ctx)
		if err != nil {
			return nil, err
		}

		_, err = user.Update().AddSubjects(subject).Save(ctx)
		if err != nil {
			return nil, err
		}
	}

	return user, nil
}

func (ur *UserRepository) CreateFriendship(ctx context.Context, userID string, friendID string) (*ent.Friendship, error) {
	currentUser, err := ur.client.User.Query().Where(user.IDEQ(userID)).Only(ctx)
	friend, err := ur.client.User.Query().Where(user.IDEQ(friendID)).Only(ctx)
	if err != nil {
		return nil, errors.New("friend not found")
	}

	friendship, err := ur.client.Friendship.
		Create().
		SetStatus("PENDING").
		SetUser(currentUser).
		SetFriend(friend).
		Save(ctx)
	if err != nil {
		return nil, err
	}

	return friendship, nil
}

func (ur *UserRepository) UpdateFriendship(friendshipID string) (*ent.Friendship, error) {
	friendship, err := ur.client.Friendship.Query().Where(friendship.IDEQ(friendshipID)).Only(context.Background())
	if err != nil {
		return nil, errors.New("friendship not found")
	}

	friendshipUpdated, err := friendship.Update().SetStatus("ACCEPTED").Save(context.Background())
	if err != nil {
		return nil, err
	}

	return friendshipUpdated, nil
}

func (ur *UserRepository) GetFriendshipById(friendshipID string) (*ent.Friendship, error) {
	friendship, err := ur.client.Friendship.Query().
		Where(friendship.IDEQ(friendshipID)).
		WithFriend().
		WithUser().
		Only(context.Background())
	if err != nil {
		return nil, errors.New("friendship not found")
	}

	return friendship, nil
}

func (ur *UserRepository) GetFriendshipsByUserId(userID string) ([]*ent.Friendship, error) {
	friendships, err := ur.client.Friendship.Query().
		Where(
			friendship.And(
				friendship.StatusEQ("ACCEPTED"),
				friendship.Or(
					friendship.HasUserWith(user.IDEQ(userID)),
					friendship.HasFriendWith(user.IDEQ(userID)),
				),
			),
		).
		WithFriend().
		WithUser().
		All(context.Background())
	if err != nil {
		return nil, err
	}

	return friendships, nil
}

func (ur *UserRepository) DeleteFriendship(friendshipID string) error {
	_, err := ur.client.Friendship.Delete().Where(friendship.IDEQ(friendshipID)).Exec(context.Background())
	if err != nil {
		return err
	}

	return nil
}

func (ur *UserRepository) IsFriendshipExist(userId1 string, userId2 string) (bool, error) {
	exist, err := ur.client.Friendship.Query().
		Where(
			// Condition for userId1 being a friend of userId2 or vice versa

			friendship.Or(
				friendship.And(
					friendship.HasUserWith(user.IDEQ(userId1)),
					friendship.HasFriendWith(user.IDEQ(userId2)),
				),
				friendship.And(
					friendship.HasUserWith(user.IDEQ(userId2)),
					friendship.HasFriendWith(user.IDEQ(userId1)),
				),
			),
		).
		Exist(context.Background())

	if err != nil {
		return false, err
	}

	return exist, nil
}

// On m'a fait la demande
func (ur *UserRepository) GetPendingFriendships(userID string) ([]*ent.Friendship, error) {
	friendships, err := ur.client.Friendship.Query().
		Where(
			friendship.And(
				friendship.HasFriendWith(user.IDEQ(userID)),
				friendship.StatusEQ("PENDING"),
			),
		).
		WithUser().
		All(context.Background())
	if err != nil {
		return nil, err
	}

	return friendships, nil
}
