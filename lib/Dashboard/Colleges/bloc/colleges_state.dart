part of 'colleges_bloc.dart';

@immutable
abstract class CollegesState {}

abstract class CollegesActionState extends CollegesState {}

class CollegesInitial extends CollegesState {}

class FacthCollegesDataLoadingState extends CollegesState {}

class FacthCollegesDataSuccessState extends CollegesState {
  final List colleges;

  FacthCollegesDataSuccessState({required this.colleges});
}
