import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:college_admission/LogIn/Repo/LogInRepo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
   on<SignUpSuccessEvent>(signUpSuccessEvent);
    on<SignUpToSignInEvent>(signUpToSignInEvent);
  }
  FutureOr<void> signUpSuccessEvent(
      SignUpSuccessEvent event, Emitter<SignUpState> emit) async {
    String isTrueSign = await LogInRepo.signUpWithEmail(event.userInfo);

    if (isTrueSign == "true") {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('KEYLOGIN', true);
      return emit(SignUpSuccessState());
    }
    return emit(SignUpErrorState(Error: isTrueSign));
  }

  FutureOr<void> signUpToSignInEvent(
      SignUpToSignInEvent event, Emitter<SignUpState> emit) {
    emit(SignUpToSignInState());
  }
  
}
