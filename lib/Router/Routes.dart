import 'package:college_admission/AllColleges/Ui/AllCollegesScreen.dart';
import 'package:college_admission/CollegeDetails/Ui/CollegeDetailsLayoutScreen.dart';
import 'package:college_admission/CollegeDetails/Ui/CollegeDetailsScreen.dart';
import 'package:college_admission/Dashboard/AddCollege/Ui/AddCollegeScreen.dart';
import 'package:college_admission/Dashboard/Colleges/Ui/CollegesScreen.dart';
import 'package:college_admission/Dashboard/Ui/DashboardScreen.dart';
import 'package:college_admission/Dashboard/Users/Ui/UsersScreen.dart';
import 'package:college_admission/Home/Home/Ui/HomeScreen.dart';
import 'package:college_admission/Home/Home/Ui/HomeScreenWeb.dart';
import 'package:college_admission/LogIn/SignIn/Ui/SignInLayoutSreen.dart';
import 'package:college_admission/LogIn/SignIn/Ui/SignInScreen.dart';
import 'package:college_admission/LogIn/SignUp/Ui/SignUpLayoutWeb.dart';
import 'package:college_admission/LogIn/SignUp/Ui/SignUpScreen.dart';
import 'package:college_admission/MyCollege/Ui/MyCollegeScreen.dart';
import 'package:college_admission/Navbar/BottomNavbar/Ui/BottomNabBarScreen.dart';
import 'package:college_admission/Profile/Ui/ProfileScreen.dart';
import 'package:college_admission/Splash/Ui/SplashScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyAppRoute {
  static GoRouter router = GoRouter(routes: [
    GoRoute(
        path: "/",
        pageBuilder: (context, state) => MaterialPage(child: SplashScreen()),
        routes: [
          GoRoute(
            path: "signUp",
            pageBuilder: (context, state) =>
                MaterialPage(child: SignUpLayout()),
          ),
          GoRoute(
            path: "signIn",
            pageBuilder: (context, state) =>
                MaterialPage(child: SignInLayout()),
          ),
          GoRoute(
            path: "home",
            pageBuilder: (context, state) => MaterialPage(child: HomeScreen()),
          ),
          GoRoute(
            path: "profile",
            pageBuilder: (context, state) =>
                MaterialPage(child: ProfileScreen()),
          ),
          GoRoute(
              path: "college",
              builder: (context, state) {
                return CollegeDetailsLayout(
                  argument: state.extra as Object,
                );
              }),
          GoRoute(
            path: "myCollege",
            pageBuilder: (context, state) =>
                MaterialPage(child: MyCollegeScreen()),
          ),
          GoRoute(
            path: "allCollege",
            pageBuilder: (context, state) =>
                MaterialPage(child: AllCollegesScreen()),
          ),
          GoRoute(
              path: "dashboard",
              pageBuilder: (context, state) =>
                  MaterialPage(child: DashboardScreen()),
              routes: [
                GoRoute(
                  path: "addCollege",
                  pageBuilder: (context, state) =>
                      MaterialPage(child: AddCollegeScreen()),
                ),
                GoRoute(
                  path: "colleges",
                  pageBuilder: (context, state) =>
                      MaterialPage(child: CollegesScreen()),
                ),
                GoRoute(
                  path: "users",
                  pageBuilder: (context, state) =>
                      MaterialPage(child: UsersScreen()),
                )
              ]),
        ])
  ]);
}
