import 'package:flutter/material.dart';
import 'package:mimic/modules/onboarding/on_boarding_screen.dart';
import 'package:mimic/presentation/resourses/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: getApplicationTheme(),
      home: OnBoarding(),
    );
  }
}
