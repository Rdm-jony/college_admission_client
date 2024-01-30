import 'package:college_admission/AllColleges/Ui/AllCollegesScreen.dart';
import 'package:college_admission/Dashboard/Ui/DashboardScreen.dart';
import 'package:college_admission/Home/Home/Ui/HomeScreen.dart';
import 'package:college_admission/MyCollege/Ui/MyCollegeScreen.dart';
import 'package:college_admission/Navbar/BottomNavbar/Repo/NavbarRepo.dart';
import 'package:college_admission/Profile/Ui/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BottomNavbar extends StatefulWidget {
  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  var userRole;
  @override
  void initState() {
    // TODO: implement initState
    userRoleFuction();
    super.initState();
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    if (userRole == "admin") {
      return [
        HomeScreen(),
        AllCollegesScreen(),
        MyCollegeScreen(),
        ProfileScreen(),
        DashboardScreen()
      ];
    }
    return [
      HomeScreen(),
      AllCollegesScreen(),
      MyCollegeScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    if (userRole == "admin") {
      return [
        PersistentBottomNavBarItem(
            icon: Icon(
          Icons.home,
        )),
        PersistentBottomNavBarItem(icon: Icon(Icons.collections)),
        PersistentBottomNavBarItem(icon: Icon(Icons.my_library_add_sharp)),
        PersistentBottomNavBarItem(icon: Icon(Icons.person)),
        PersistentBottomNavBarItem(icon: Icon(Icons.dashboard)),
      ];
    }
    return [
      PersistentBottomNavBarItem(
          icon: Icon(
        Icons.home,
      )),
      PersistentBottomNavBarItem(icon: Icon(Icons.collections)),
      PersistentBottomNavBarItem(icon: Icon(Icons.my_library_add_sharp)),
      PersistentBottomNavBarItem(icon: Icon(Icons.person)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),

      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }

  void userRoleFuction() async {
    userRole = await NavbarRepo.fatchUserRole();
    setState(() {});
  }
}
