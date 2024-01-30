part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpSuccessEvent extends SignUpEvent {
  final Object userInfo;

  SignUpSuccessEvent({required this.userInfo});
}
class SignUpToSignInEvent extends SignUpEvent{}
