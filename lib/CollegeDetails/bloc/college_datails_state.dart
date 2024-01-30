part of 'college_datails_bloc.dart';

@immutable
abstract class CollegeDetailsState {}
abstract class CollegeDetailsActionState extends CollegeDetailsState{}

class CollegeDetailsInitial extends CollegeDetailsState {}
class SenFormDataSuccess extends CollegeDetailsActionState{}
class SendFeedbackSuccessState extends CollegeDetailsActionState{}
