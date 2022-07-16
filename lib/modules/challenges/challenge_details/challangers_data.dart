import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/challenges/widgets/challenges_grid_view.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';

class ChallangersData extends StatelessWidget {
  const ChallangersData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChallengesGridView(context: context),
        Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Builder(builder: (context) {
            return TextButton(
              onPressed: () {
                navigateTo(context, Routes.allChallengers);
              },
              child: Text(
                'VIEW ALL >>',
                style: getRegularStyle(
                        fontSize: FontSize.s8,
                        color: ColorManager.visibilityColor)
                    .copyWith(decoration: TextDecoration.underline),
              ),
            );
          }),
        ),
      ],
    );
  }
}
