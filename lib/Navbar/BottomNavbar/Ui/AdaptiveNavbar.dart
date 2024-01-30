import 'package:college_admission/Navbar/BottomNavbar/Repo/NavbarRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class WebNavbarWidget extends StatefulWidget {
  const WebNavbarWidget({super.key});

  @override
  State<WebNavbarWidget> createState() => _WebNavbarWidgetState();
}

class _WebNavbarWidgetState extends State<WebNavbarWidget> {
  var userRole;
  @override
  void initState() {
    // TODO: implement initState
    userRoleFuction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(userRole);
    return AdaptiveNavBar(
      title: CircleAvatar(
        backgroundImage: AssetImage("assets/images/admission_logo.png"),
      ),
      automaticallyImplyLeading: false,
      screenWidth: 100.w,
      navBarItems: [
        NavBarItem(
          text: "Home",
          onTap: () {
            context.go("/home");
          },
        ),
        NavBarItem(
          text: "My College",
          onTap: () {
            context.go("/myCollege");
          },
        ),
        NavBarItem(
          text: "All College",
          onTap: () {
            context.go("/allCollege");
          },
        ),
        NavBarItem(
          text: "Profile",
          onTap: () {
            context.go("/profile");
          },
        ),
        userRole == "admin"
            ? NavBarItem(
                text: "Dashboard",
                onTap: () {
                  context.go("/dashboard");
                },
              )
            : NavBarItem(text: ""),
      ],
    );
  }

  void userRoleFuction() async {
    userRole = await NavbarRepo.fatchUserRole();
    setState(() {});
  }
}
