part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class FatchProfileDataEvent extends ProfileEvent {}

class UpLaodImageEvent extends ProfileEvent {}

class UpdateUserInfoEvent extends ProfileEvent {
  final updateUserInfo;

  UpdateUserInfoEvent({required this.updateUserInfo});
}
