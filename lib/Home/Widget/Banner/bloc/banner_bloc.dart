import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:college_admission/Home/Widget/Banner/Repo/BannerRepo.dart';
import 'package:meta/meta.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc() : super(BannerInitial()) {
    on<FachSliderCardEvent>(fachSliderCardEvent);
  }

  FutureOr<void> fachSliderCardEvent(
      FachSliderCardEvent event, Emitter<BannerState> emit) async {
    emit(FatchInitailLoadingState());
    final List colleges = await BannerRepo.faltchBannerData();
  
    emit(FatchInitailSuccessState(bannerData: colleges));
  }
}
