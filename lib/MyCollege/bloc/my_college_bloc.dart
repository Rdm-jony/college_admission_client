import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:college_admission/MyCollege/Repo/MayCollegeRepo.dart';
import 'package:meta/meta.dart';

part 'my_college_event.dart';
part 'my_college_state.dart';

class MyCollegeBloc extends Bloc<MyCollegeEvent, MyCollegeState> {
  MyCollegeBloc() : super(MyCollegeInitial()) {
    on<FatchCollegeDataEvent>(fatchCollegeDataEvent);
  }

  FutureOr<void> fatchCollegeDataEvent(
      FatchCollegeDataEvent event, Emitter<MyCollegeState> emit) async {
    emit(FatchMyCollegeDataLoadingState());
    List myColleges = await MyCollegeRepo.facthCollegeData();
    print(myColleges);
    emit(FatchMyCollegeDataSuccessState(myColleges: myColleges));
  }
}
