import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class ChallengeTitle extends StatelessWidget {
  const ChallengeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Family Challenge',
      style: getBoldStyle(fontSize: FontSize.s14),
    );
  }
}

class ChallengeDescription extends StatelessWidget {
  const ChallengeDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.challengeDiscription,
      maxLines: 4,
      style: getRegularStyle(
          fontSize: FontSize.s10, color: ColorManager.challengeDescription),
    );
  }
}
