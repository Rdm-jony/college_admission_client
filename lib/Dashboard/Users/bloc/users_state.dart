part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

abstract class UsersActionState extends UsersState {}

class UsersInitial extends UsersState {}

class FatchAllUsersLoadingState extends UsersState {}

class FatchAllUsersSuccessState extends UsersState {
  final List users;

  FatchAllUsersSuccessState({required this.users});
}
