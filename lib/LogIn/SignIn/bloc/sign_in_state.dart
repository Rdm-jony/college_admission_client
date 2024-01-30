part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {}

abstract class SignInActionState extends SignInState {}

class SignInInitial extends SignInState {}

class SignInSuceessState extends SignInActionState {}

class SignInErrorState extends SignInActionState {
  final String Error;

  SignInErrorState({required this.Error});
}

class SignInToSignUpState extends SignInActionState{}
