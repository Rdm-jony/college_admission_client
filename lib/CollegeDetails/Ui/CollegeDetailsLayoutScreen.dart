import 'package:college_admission/CollegeDetails/Ui/CollegeDetailsScreemWeb.dart';
import 'package:college_admission/CollegeDetails/Ui/CollegeDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CollegeDetailsLayout extends StatelessWidget {
  final argument;

  const CollegeDetailsLayout({super.key, required this.argument});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth < 600) {
          return CollegeDetailsScreen(argument: argument);
        }
        return CollegeDetailsScreenWeb(argument: argument);
      },
    );
  }
}
