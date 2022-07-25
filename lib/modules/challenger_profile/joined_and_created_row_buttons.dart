
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/enums/challengesUser.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/extentions/translate_word.dart';

import 'cubit/challanger_profile_cubit.dart';

class JoinedAndCreatedRowButtons extends StatefulWidget {
   // ignore: prefer_const_constructors_in_immutables
   JoinedAndCreatedRowButtons({Key? key}) : super(key: key);

  @override
  State<JoinedAndCreatedRowButtons> createState() =>
      _JoinedAndCreatedRowButtonsState();
}

class _JoinedAndCreatedRowButtonsState
    extends State<JoinedAndCreatedRowButtons> {
  @override
  Widget build(BuildContext context) {
    ChallangerProfileCubit challangerProfileCubit =
        ChallangerProfileCubit.get(context);
    // log(ChallengesUserEnum.created.index.toString());
    return IntrinsicHeight(
      child: Row(
        children: [
          GestureDetector(
            onTap: () => challangerProfileCubit.selectFilteredChallenges(0),
            child: Text(ChallengesUserEnum.created.name.translateString(context),
                style: getSemiBoldStyle(
                    fontSize: FontSize.s20,
                    color: challangerProfileCubit.selectedFilter == 0
                        ? ColorManager.visibilityColor
                        : ColorManager.commentsColor)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: VerticalDivider(
                thickness: 2, color: ColorManager.commentsColor),
          ),
          GestureDetector(
            onTap: () => challangerProfileCubit.selectFilteredChallenges(1),
            child: Text(ChallengesUserEnum.joined.name.translateString(context),
                style: getSemiBoldStyle(
                    fontSize: FontSize.s20,
                    color: challangerProfileCubit.selectedFilter == 1
                        ? ColorManager.visibilityColor
                        : ColorManager.commentsColor)),
          ),
        ],
      ),
    );
  }
}
