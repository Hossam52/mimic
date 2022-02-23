import 'dart:math';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/onboarding/on_boarding_screen.dart';
import 'package:mimic/presentation/resourses/theme_manager.dart';

final videoPaths = [
  'assets/images/static/video_images/video1.png',
  'assets/images/static/video_images/video2.png',
  'assets/images/static/video_images/video3.png',
  'assets/images/static/video_images/video4.png',
  'assets/images/static/video_images/video5.png',
];
String getVideoImageRandom() {
  return videoPaths[Random.secure().nextInt(videoPaths.length)];
}

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 820),
      builder: () => MaterialApp(
        title: 'MIMIC',
        theme: getApplicationTheme(),
        home: OnBoarding(),
      ),
    );
  }
}
