import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:college_admission/CollegeDetails/Repo/CollegeDetailsRepo.dart';
import 'package:meta/meta.dart';

part 'college_datails_event.dart';
part 'college_datails_state.dart';

class CollegeDetailsBloc
    extends Bloc<CollegeDatailsEvent, CollegeDetailsState> {
  CollegeDetailsBloc() : super(CollegeDetailsInitial()) {
    on<SendFeedbackEvent>(sendFeedbackEvent);
    on<SendFormDataEvent>(sendFormDataEvent);
  }

  FutureOr<void> sendFeedbackEvent(
      SendFeedbackEvent event, Emitter<CollegeDetailsState> emit) async {
    bool isTrue = await CollegeDetailsRepo.sendFeedback(event.feedback);
    if (isTrue) {
      emit(SendFeedbackSuccessState());
    }
  }

  FutureOr<void> sendFormDataEvent(
      SendFormDataEvent event, Emitter<CollegeDetailsState> emit) async {
    bool isTrue = await CollegeDetailsRepo.sendFormdata(
        event.formDetails, event.collegeId);
    if (isTrue) {
      emit(SenFormDataSuccess());
    }
  }
}
