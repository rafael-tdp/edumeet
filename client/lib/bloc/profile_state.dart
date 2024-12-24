import 'package:client/core/models/user.dart';

abstract class ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final User user;

  ProfileLoadedState(this.user);
}

class ProfileErrorState extends ProfileState {
  final String message;

  ProfileErrorState(this.message);
}
