import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_covid_dashboard_ui/screens/screens.dart';
import 'package:flutter_covid_dashboard_ui/screens/splashScreen.dart';
import 'package:flutter_covid_dashboard_ui/util/statefulWidget.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  StateWidget stateWidget = new StateWidget(
    child: new MyApp(),
  );
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new GetMaterialApp(home: stateWidget));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Covid-19 Dashboard UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: 
      (FirebaseAuth.instance.currentUser != null)
          ? BottomNavScreen()
          : SplashScreen(),
    );
  }
}
