import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/ranks/my_statictics.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

import 'requirement_item.dart';

class MyStatictiscsWidget extends StatelessWidget {
  const MyStatictiscsWidget(
      {Key? key, required this.myStatictics, required this.levelId})
      : super(key: key);
  final MyStatictics myStatictics;
  final int levelId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'your statictics',
          style: getBoldStyle(color: ColorManager.primary),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16.h),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          height: 140.h,
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
                    RequirementItem(
                        title: 'Number of challenges',
                        value: myStatictics.myChallengesCount),
                    SizedBox(
                      height: 3.h,
                    ),
                    RequirementItem(
                        title: 'Number of videos',
                        value: myStatictics.myVideosCount),
                    SizedBox(
                      height: 3.h,
                    ),
                    RequirementItem(
                        title: 'Number of likes',
                        value: myStatictics.myLikesCount),
                    SizedBox(
                      height: 3.h,
                    ),
                    RequirementItem(
                        title: 'Number of invites',
                        value: myStatictics.myInvitesCount),
                  ],
                ),
              ),
              // cachedNetworkImage(
              //     imageUrl: rank.imageUrl, height: 92.r, width: 92.r),
            ],
          ),
        ),
        if (myStatictics.authLevel >= levelId)
          Text(
            'You achieved this level already :)',
            style: getBoldStyle(color: ColorManager.primary),
          ),
      ],
    );
  }
}
