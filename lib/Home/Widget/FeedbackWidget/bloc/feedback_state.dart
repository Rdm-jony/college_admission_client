part of 'feedback_bloc.dart';

@immutable
abstract class FeedbackState {}

abstract class FeedbackActionState extends FeedbackState {}

class FeedbackInitial extends FeedbackState {}

class FeedbackLoadingState extends FeedbackState {}

class FeedbackSuccessState extends FeedbackState {
  final List feedbacks;

  FeedbackSuccessState({required this.feedbacks});
}
