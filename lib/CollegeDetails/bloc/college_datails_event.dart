part of 'college_datails_bloc.dart';

@immutable
abstract class CollegeDatailsEvent {}

class SendFormDataEvent extends CollegeDatailsEvent {
  final String collegeId;
  final Object formDetails;

  SendFormDataEvent({required this.collegeId, required this.formDetails});
}

class SendFeedbackEvent extends CollegeDatailsEvent {
  final Object feedback;

  SendFeedbackEvent({required this.feedback});
}
