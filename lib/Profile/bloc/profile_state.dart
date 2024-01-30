part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

abstract class ProfileActionState extends ProfileState {}

class ProfileInitial extends ProfileState {}

class FatchProfileDataSuccessState extends ProfileState {
  final Map profileData;

  FatchProfileDataSuccessState({required this.profileData});
}
class FatchProfileDataLoadingState extends ProfileState{}
