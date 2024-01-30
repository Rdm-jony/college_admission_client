import 'package:college_admission/Home/Widget/Banner/Ui/CardWidget.dart';
import 'package:college_admission/Home/Widget/Banner/bloc/banner_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  BannerBloc bannerBloc = BannerBloc();
  @override
  void initState() {
    bannerBloc.add(FachSliderCardEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BannerBloc, BannerState>(
      bloc: bannerBloc,
      listenWhen: (previous, current) => current is BannerActionState,
      buildWhen: (previous, current) => current is! BannerActionState,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        print(state);
        switch (state.runtimeType) {
          case FatchInitailLoadingState:
            return Center(child: CircularProgressIndicator());

          case FatchInitailSuccessState:
            final success = state as FatchInitailSuccessState;
            return Column(
              children: [
                Text(
                  "Top Colleges:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                CarouselSlider(
                  options: CarouselOptions(height: 450.0),
                  items: success.bannerData.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return CardWidget(
                          cardData: i,
                          bloc: bannerBloc,
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            );
          default:
        }
        return Container();
      },
    );
  }
}
