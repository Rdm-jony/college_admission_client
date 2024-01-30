part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

abstract class SignUpActionState extends SignUpState {}

class SignUpSuccessState extends SignUpActionState {}

class SignUpErrorState extends SignUpActionState {
  final String Error;

  SignUpErrorState({required this.Error});
}
class SignUpToSignInState extends SignUpActionState{}