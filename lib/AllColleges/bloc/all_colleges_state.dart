part of 'all_colleges_bloc.dart';

@immutable
abstract class AllCollegesState {}

abstract class AllCollegesActionState extends AllCollegesState {}

class AllCollegesInitial extends AllCollegesState {}

class FatchAllCollegesLoadingState extends AllCollegesState {}

class FatchAllCollegesSuccessState extends AllCollegesState {
  final List allColleges;

  FatchAllCollegesSuccessState({required this.allColleges});
}


