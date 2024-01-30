import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:college_admission/AllColleges/bloc/all_colleges_bloc.dart';
import 'package:college_admission/Dashboard/Colleges/Repo/CollegesRepo.dart';
import 'package:meta/meta.dart';

part 'colleges_event.dart';
part 'colleges_state.dart';

class CollegesBloc extends Bloc<CollegesEvent, CollegesState> {
  CollegesBloc() : super(CollegesInitial()) {
    on<FatchCollegesEvent>(fatchCollegesEvent);
    on<CollegesAddToTopEvent>(collegesAddToTopEvent);
  }

  FutureOr<void> fatchCollegesEvent(
      FatchCollegesEvent event, Emitter<CollegesState> emit) async {
    emit(FacthCollegesDataLoadingState());
    List colleges = await CollegesRepo.fatchCollegesData();

    emit(FacthCollegesDataSuccessState(colleges: colleges));
  }

  FutureOr<void> collegesAddToTopEvent(
      CollegesAddToTopEvent event, Emitter<CollegesState> emit) async {
    bool isTrue =
        await CollegesRepo.collegeAddToTop(event.collegeId, event.isTop);
    if (isTrue) {
      List colleges = await CollegesRepo.fatchCollegesData();

      emit(FacthCollegesDataSuccessState(colleges: colleges));
    }
  }
}
