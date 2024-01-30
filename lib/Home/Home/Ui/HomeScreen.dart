import 'package:college_admission/Home/Widget/Banner/Ui/BannerWidget.dart';
import 'package:college_admission/Home/Widget/FeedbackWidget/Ui/FeedbackWidget.dart';
import 'package:college_admission/Home/Widget/SliderWidget/Ui/SliderWidget.dart';
import 'package:college_admission/Navbar/BottomNavbar/Ui/AdaptiveNavbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb
          ? AppBar(
              leadingWidth: 100.w,
              leading: WebNavbarWidget(),
            )
          : AppBar(
              title: Text("Home"),
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
