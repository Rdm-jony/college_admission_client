import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:college_admission/Home/Widget/FeedbackWidget/Repo/FeedbackRepo.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(FeedbackInitial()) {
    on<FatchInitialFeedbackEvent>(fatchInitialFeedbackEvent);
  }

  FutureOr<void> fatchInitialFeedbackEvent(
      FatchInitialFeedbackEvent event, Emitter<FeedbackState> emit) async {
    emit(FeedbackLoadingState());
    List feedbacks = await FeedbackRepo.fatchFeedback();
    emit(FeedbackSuccessState(feedbacks: feedbacks));
  }
}
