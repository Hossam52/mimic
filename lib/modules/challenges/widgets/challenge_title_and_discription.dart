import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class ChallengeTitle extends StatelessWidget {
  const ChallengeTitle({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: getBoldStyle(fontSize: FontSize.s14),
    );
  }
}

class ChallengeDescription extends StatelessWidget {
  const ChallengeDescription({Key? key,required this.description}) : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
    description,
      maxLines: 4,
      style: getRegularStyle(
          fontSize: FontSize.s10, color: ColorManager.challengeDescription),
    );
  }
}
