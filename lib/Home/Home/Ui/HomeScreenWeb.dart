import 'package:college_admission/Home/Widget/Banner/Ui/BannerWidget.dart';
import 'package:college_admission/Home/Widget/FeedbackWidget/Ui/FeedbackWidget.dart';
import 'package:college_admission/Home/Widget/SliderWidget/Ui/SliderWidget.dart';
import 'package:college_admission/Navbar/BottomNavbar/Ui/AdaptiveNavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';
import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Entry point of the application

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({super.key});

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: sw,
        leading: WebNavbarWidget(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              child: ImageGallery(),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: BannerWidget(),
            ),
            Container(
              width: 90.w,
              height: 300,
              child: ReviewWidget(),
            )
          ],
        ),
      ),
    );
  }
}
