part of 'my_college_bloc.dart';

@immutable
abstract class MyCollegeState {}

abstract class MyCollegeActionState extends MyCollegeState {}

class MyCollegeInitial extends MyCollegeState {}

class FatchMyCollegeDataLoadingState extends MyCollegeState {}

class FatchMyCollegeDataSuccessState extends MyCollegeState {
  final List myColleges;

  FatchMyCollegeDataSuccessState({required this.myColleges});
}
