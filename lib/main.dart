import 'package:college_admission/Router/Routes.dart';
import 'package:college_admission/Splash/Ui/SplashScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCfz-iY0iql2sRnlJ_z8N-9nv_0CFIzEs4",
            authDomain: "collegeadmission-42d1f.firebaseapp.com",
            appId: "1:845408108695:web:3592fc41df66efc309e9d2",
            storageBucket: "collegeadmission-42d1f.appspot.com",
            messagingSenderId: "845408108695",
            projectId: "collegeadmission-42d1f"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
  setPathUrlStrategy();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          theme: ThemeData(
              primarySwatch: Colors.blue,
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white),
              )),
          debugShowCheckedModeBanner: false,
          routerConfig: MyAppRoute.router,
        );
      },
    );
  }
}
