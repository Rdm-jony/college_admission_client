import 'package:college_admission/Dashboard/AddCollege/Ui/AddCollegeScreen.dart';
import 'package:college_admission/Dashboard/Colleges/Ui/CollegesScreen.dart';
import 'package:college_admission/Dashboard/Users/Ui/UsersScreen.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var index = 0;

  List selectpage = [AddCollegeScreen(), CollegesScreen(), UsersScreen()];

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Add College',
            route: '/dashboard/addCollege',
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Colleges',
            route: '/dashboard/colleges',
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Users',
            route: '/dashboard/users',
            icon: Icons.dashboard,
          ),
        ],
        selectedRoute: '/dashboard/addCollege',
        onSelected: (item) {
          if (item.route == "/dashboard/addCollege") {
            index = 0;
            setState(() {});
          } else if (item.route == '/dashboard/colleges') {
            index = 1;
            setState(() {});
          } else if (item.route == '/dashboard/users') {
            index = 2;
            setState(() {});
          }
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'header',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'footer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: selectpage[index],
    );
  }
}
