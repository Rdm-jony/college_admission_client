import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:college_admission/AllColleges/Repo/AllCollegesRepo.dart';
import 'package:meta/meta.dart';

part 'all_colleges_event.dart';
part 'all_colleges_state.dart';

class AllCollegesBloc extends Bloc<AllCollegesEvent, AllCollegesState> {
  AllCollegesBloc() : super(AllCollegesInitial()) {
    on<FatchAllCollegesEvent>(fatchAllCollegesEvent);
  }

  FutureOr<void> fatchAllCollegesEvent(
      FatchAllCollegesEvent event, Emitter<AllCollegesState> emit) async {
    emit(FatchAllCollegesLoadingState());
    List allColleges = await AllCollegesRepo.fatchAllCollegesData();
    emit(FatchAllCollegesSuccessState(allColleges: allColleges));
  }
}
