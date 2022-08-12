import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/ranks/rank.dart';
import 'package:mimic/modules/my_profile/all_ranks/widgets/requirement_item.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/widgets/cached_network_image.dart';

class LevelItemRequirements extends StatelessWidget {
  const LevelItemRequirements({Key? key, required this.rank}) : super(key: key);
  final Rank rank;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.levelRequirements.translateString(context),
          style: getBoldStyle(),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16.h),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          height: 160.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: ColorManager.selectedColor,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      rank.title == '' ? 'title' : rank.title,
                      style: getSemiBoldStyle(fontSize: FontSize.s14),
                    ),
                    RequirementItem(
                        title: AppStrings.numberOfChallenges,
                        value: rank.challengesNumber),
                    SizedBox(
                      height: 3.h,
                    ),
                    RequirementItem(
                        title: AppStrings.numberOfVideos,
                        value: rank.videosNumber),
                    SizedBox(
                      height: 3.h,
                    ),
                    RequirementItem(
                        title: AppStrings.numberOfLikes,
                        value: rank.likesNumber),
                    SizedBox(
                      height: 3.h,
                    ),
                    RequirementItem(
                        title: AppStrings.numberofInvites,
                        value: rank.invitesNumber),
                  ],
                ),
              ),
              cachedNetworkImage(
                  imageUrl: rank.imageUrl, height: 92.r, width: 92.r),
            ],
          ),
        ),
      ],
    );
  }
}
