part of 'colleges_bloc.dart';

@immutable
abstract class CollegesEvent {}

class FatchCollegesEvent extends CollegesEvent {}

class CollegesAddToTopEvent extends CollegesEvent {
  final String collegeId;
  final bool isTop;

  CollegesAddToTopEvent({required this.collegeId ,required this.isTop});
}
