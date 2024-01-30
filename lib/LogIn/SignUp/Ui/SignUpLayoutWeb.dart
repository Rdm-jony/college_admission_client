import 'package:college_admission/LogIn/SignUp/Ui/SignUpScreen.dart';
import 'package:college_admission/LogIn/SignUp/Ui/SignUpScreenWeb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SignUpLayout extends StatelessWidget {
  const SignUpLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth < 600) {
          return SignUpScreen();
        }
        return SignUpScreenWeb();
      },
    );
  }
}
