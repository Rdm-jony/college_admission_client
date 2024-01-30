import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    whereToGo();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/admission_logo.png"),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(width: 30.w, child: LinearProgressIndicator())
            ],
          ),
        ));
  }

  void whereToGo() {
    Timer(Duration(seconds: 2), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool? isLogedIn = prefs.getBool('KEYLOGIN');
      if (isLogedIn != null) {
        if (isLogedIn) {
          context.go("/home");
        } else {
          context.go("/signIn");
        }
      } else {
        context.go("/signIn");
      }
    });
  }
}
