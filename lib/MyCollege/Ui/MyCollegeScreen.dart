import 'package:college_admission/Home/Widget/Banner/Ui/CardWidget.dart';
import 'package:college_admission/MyCollege/bloc/my_college_bloc.dart';
import 'package:college_admission/Navbar/BottomNavbar/Ui/AdaptiveNavbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class MyCollegeScreen extends StatefulWidget {
  const MyCollegeScreen({super.key});

  @override
  State<MyCollegeScreen> createState() => _MyCollegeScreenState();
}

class _MyCollegeScreenState extends State<MyCollegeScreen> {
  MyCollegeBloc myCollegeBloc = MyCollegeBloc();
  @override
  void initState() {
    myCollegeBloc.add(FatchCollegeDataEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: kIsWeb
          ? AppBar(
              leadingWidth: 100.w,
              leading: WebNavbarWidget(),
            )
          : AppBar(
              title: Text("My college"),
            ),
      body: BlocConsumer<MyCollegeBloc, MyCollegeState>(
        bloc: myCollegeBloc,
        listenWhen: (previous, current) => current is MyCollegeActionState,
        buildWhen: (previous, current) => current is! MyCollegeActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case FatchMyCollegeDataLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );

            case FatchMyCollegeDataSuccessState:
              final success = state as FatchMyCollegeDataSuccessState;
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  width: screenWidth,
                  height: screenHeight,
                  child: ListView.builder(
                    itemCount: success.myColleges.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CardWidget(
                          routeName: "mycollege",
                          bloc: myCollegeBloc,
                          cardData: success.myColleges[index],
                        ),
                      );
                    },
                  ),
                ),
              );
            default:
          }
          return Container();
        },
      ),
    );
  }
}
