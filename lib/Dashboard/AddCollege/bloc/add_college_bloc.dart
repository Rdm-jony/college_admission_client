import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:college_admission/Dashboard/AddCollege/Repo/AddCollegeRepo.dart';
import 'package:meta/meta.dart';

part 'add_college_event.dart';
part 'add_college_state.dart';

class AddCollegeBloc extends Bloc<AddCollegeEvent, AddCollegeState> {
  AddCollegeBloc() : super(AddCollegeInitial()) {
    on<AddCollegePostEvent>(addCollegePostEvent);
  }

  FutureOr<void> addCollegePostEvent(
      AddCollegePostEvent event, Emitter<AddCollegeState> emit) async {
    bool isTrue = await AddCollegeRepo.sendAddCollegeOnfo(event.collegeInfo);
    if (isTrue) {
      emit(AddCollegeSuccessState());
    }
  }
}
