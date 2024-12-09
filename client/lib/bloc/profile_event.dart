import 'package:client/core/models/user.dart';

abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final User updatedUser;

  UpdateProfileEvent(this.updatedUser);
}
