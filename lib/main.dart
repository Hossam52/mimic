import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/bloc_observer.dart';
import 'package:mimic/layout/guest/guest_main_layout.dart';
import 'package:mimic/layout/user/user_main_layout.dart';
import 'package:mimic/modules/onboarding/on_boarding_screen.dart';
import 'package:mimic/modules/video_play_test.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/theme_manager.dart';
import 'package:mimic/presentation/resourses/values_manager.dart';
import 'package:mimic/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:mimic/shared/cubits/language_cubit/languages_cubit.dart';
import 'package:mimic/shared/cubits/language_cubit/languages_states.dart';
import 'package:mimic/shared/network/locale/cache_helper.dart';
import 'package:mimic/shared/network/remote/dio_helper.dart';
import 'package:mimic/shared/services/security_services.dart';
import 'modules/my_profile/profile_cubit/profile_cubit.dart';
import 'shared/localization/mimic_localiaze.dart';

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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  HttpOverrides.global = MyHttpOverrides();
  SecurityServices.init();
  await CacheHelper.init();
  DioHelper.init();
  await Firebase.initializeApp();
  
  ValuesManager.username =
      CacheHelper.getDate(key: ValuesManager.usernameKey) ?? 'Tour user';
  ValuesManager.email =
      CacheHelper.getDate(key: ValuesManager.emailKey) ?? 'user@exmaple.com';
  ValuesManager.imageUrl =
      CacheHelper.getDate(key: ValuesManager.imageKey) ?? '';
  ValuesManager.tokenValue =
      CacheHelper.getDate(key: ValuesManager.tokenKey) ?? '';
  ValuesManager.onboarding =
      CacheHelper.getDate(key: ValuesManager.onboardingKey) ?? false;

  BlocOverrides.runZoned(
    () {
      runApp(MyApp()
          // DevicePreview(
          //   enabled: !kReleaseMode,
          //   builder: (context) => MyApp(), // Wrap your app
          // ),
          );
    },
    blocObserver: MyBlocObserver(),
  );
}

Widget mainWidget() {
  if (ValuesManager.tokenValue.isNotEmpty) {
    dev.log(ValuesManager.tokenValue.toString());
    // return const VideoItemPlayer();
    return const UserMainLayout();
  } else if (ValuesManager.onboarding) {
    return const GuestMainLayout();
  } else {
    return OnBoarding();
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 820),
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(),
          ),
          BlocProvider(
            create: (context) => LanguagesCubit(),
          ),
        ],
        child: BlocBuilder<LanguagesCubit, LanguagesStates>(
          builder: (context, state) 
          {
            return MaterialApp(
              title: AppStrings.appName,
              supportedLocales: MimicLocalizations.supportedLocales,
              localizationsDelegates: MimicLocalizations.localizationsDelegate,
              debugShowCheckedModeBanner: false,
              theme: getApplicationTheme(),
              home: mainWidget(),
            );
          },
        ),
      ),
    );
  }
}
