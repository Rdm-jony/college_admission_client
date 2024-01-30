import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:college_admission/Profile/Repo/ProfileRepo.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FatchProfileDataEvent>(fatchProfileDataEvent);
    on<UpLaodImageEvent>(upLaodImageEvent);
    on<UpdateUserInfoEvent>(updateUserInfoEvent);
  }

  FutureOr<void> fatchProfileDataEvent(
      FatchProfileDataEvent event, Emitter<ProfileState> emit) async {
    emit(FatchProfileDataLoadingState());
    Map profileData = await ProfileRepo.fatchProfileData();
    emit(FatchProfileDataSuccessState(profileData: profileData));
  }

  FutureOr<void> upLaodImageEvent(
      UpLaodImageEvent event, Emitter<ProfileState> emit) async {
    bool isTrue = await ProfileRepo.upLoadImageToDb();
    if (isTrue) {
      Map profileData = await ProfileRepo.fatchProfileData();
      emit(FatchProfileDataSuccessState(profileData: profileData));
    }
  }

  FutureOr<void> updateUserInfoEvent(
      UpdateUserInfoEvent event, Emitter<ProfileState> emit) async {
    bool isTrue = await ProfileRepo.updateUser(event.updateUserInfo);
    if (isTrue) {
      Map profileData = await ProfileRepo.fatchProfileData();
      emit(FatchProfileDataSuccessState(profileData: profileData));
    }
  }
}
