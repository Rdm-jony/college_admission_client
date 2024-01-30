part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignInSuccessEvent extends SignInEvent {
  final String email;
  final String passsword;

  SignInSuccessEvent({required this.email,required this.passsword});
}
class SignInToSignUpEvent extends SignInEvent{}
