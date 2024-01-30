part of 'add_college_bloc.dart';

@immutable
abstract class AddCollegeState {}

abstract class AddCollegeActionState extends AddCollegeState{}

class AddCollegeInitial extends AddCollegeState {}
class AddCollegeSuccessState extends AddCollegeActionState{}

