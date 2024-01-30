part of 'banner_bloc.dart';

@immutable
abstract class BannerState {}

abstract class BannerActionState extends BannerState {}

class BannerInitial extends BannerState {}

class FatchInitailLoadingState extends BannerState {}

class FatchInitailSuccessState extends BannerState {
  final List bannerData;

  FatchInitailSuccessState({required this.bannerData});
}
