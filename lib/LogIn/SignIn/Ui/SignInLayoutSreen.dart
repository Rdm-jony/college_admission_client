import 'package:college_admission/LogIn/SignIn/Ui/SignInScreen.dart';
import 'package:college_admission/LogIn/SignIn/Ui/SignInScreenWeb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SignInLayout extends StatelessWidget {
  const SignInLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth < 600) {
          return SignInScreen();
        }

        return SignInScreenWeb();
      },
    );
  }
}
