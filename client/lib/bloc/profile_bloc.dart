import 'package:client/i18n/generated/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import 'package:client/core/services/user_services.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserServices _userServices;

  ProfileBloc(this._userServices) : super(ProfileLoadingState()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final userInfo = await _userServices.getUserInfo();
        emit(ProfileLoadedState(userInfo.data));
      } catch (e) {
        emit(ProfileErrorState(t.error.general));
      }
    });

    on<UpdateProfileEvent>((event, emit) {
      emit(ProfileLoadedState(event.updatedUser));
    });
  }
}
