import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:college_admission/LogIn/Repo/LogInRepo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInSuccessEvent>(signInSuccessEvent);
    on<SignInToSignUpEvent>(signInToSignUpEvent);
  }

  FutureOr<void> signInSuccessEvent(
      SignInSuccessEvent event, Emitter<SignInState> emit) async {
    var isTrue = await LogInRepo.signInWthEmail(event.email, event.passsword);
    if (isTrue == "true") {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('KEYLOGIN', true);

      return emit(SignInSuceessState());
    }
    return emit(SignInErrorState(Error: isTrue));
  }

  FutureOr<void> signInToSignUpEvent(
      SignInToSignUpEvent event, Emitter<SignInState> emit) {
    emit(SignInToSignUpState());
  }
}
