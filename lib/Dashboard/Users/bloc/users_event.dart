part of 'users_bloc.dart';

@immutable
abstract class UsersEvent {}

class FatchAllUsersEvent extends UsersEvent {}

class UserAddToAdminEvent extends UsersEvent {
  final String userId;
  final String role;

  UserAddToAdminEvent({required this.userId,required this.role});
}
