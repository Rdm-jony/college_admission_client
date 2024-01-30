import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:college_admission/Dashboard/Users/Repo/UsersRepo.dart';
import 'package:meta/meta.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    on<FatchAllUsersEvent>(fatchAllUsersEvent);
    on<UserAddToAdminEvent>(userAddToAdminEvent);
  }

  FutureOr<void> fatchAllUsersEvent(
      FatchAllUsersEvent event, Emitter<UsersState> emit) async {
    emit(FatchAllUsersLoadingState());
    List users = await UsersRepo.fatchAllUsers();
    emit(FatchAllUsersSuccessState(users: users));
  }

  FutureOr<void> userAddToAdminEvent(
      UserAddToAdminEvent event, Emitter<UsersState> emit) async {
    bool isTrue = await UsersRepo.userAddToAdmin(event.userId, event.role);
    if (isTrue) {
      List users = await UsersRepo.fatchAllUsers();

      emit(FatchAllUsersSuccessState(users: users));
    }
  }
}
