part of 'add_college_bloc.dart';

@immutable
abstract class AddCollegeEvent {}

class AddCollegePostEvent extends AddCollegeEvent {
  final collegeInfo;

  AddCollegePostEvent({required this.collegeInfo});
}
