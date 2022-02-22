import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class HowToChallengeScreen extends StatelessWidget {
  const HowToChallengeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('How to challenge'),
        titleTextStyle: getBoldStyle(fontSize: FontSize.s14),
        leading: BackButton(color: ColorManager.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30.w),
          child: _howToChallengeText(),
        ),
      ),
    );
  }

  Widget _howToChallengeText() {
    return Text(
      AppStrings.howToChallenge * 2,
      style: getRegularStyle(color: ColorManager.lightGrey).copyWith(
        height: 2,
        wordSpacing: 1,
        letterSpacing: 1,
      ),
    );
  }
}
