import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/challenges/challange_data_cubit/challange_data_cubit.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/defulat_button.dart';

import 'video_staticitcs.dart';

class StatisticsAndJoinButton extends StatelessWidget {
  const StatisticsAndJoinButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(ChallangeDataCubit.get(context).challangeDetails.authJoined.toString());
    return Padding(
      padding: EdgeInsets.only(
        top: 18.0.h,
        left: 8.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: VideoStatistics()),
          if (ChallangeDataCubit.get(context).challangeDetails.authJoined !=
              true)
            SizedBox(
              width: screenWidth(context) * 0.31,
              child: DefaultButton(
                // height: screenHeight(context) * 0.055,
                height: 40.h,
                text: AppStrings.join.translateString(context),
                onPressed: () async {
                  bool? isAuthJoined = await navigateTo(
                      context, Routes.addVideoToChallange,
                      arguments:
                          ChallangeDataCubit.get(context).challangeDetails.id);
                  if (isAuthJoined != null && isAuthJoined) {
                    log('Success');
                    ChallangeDataCubit.get(context)
                        .challangeDetails
                        .authJoined = isAuthJoined;
                    ChallangeDataCubit.get(context).rebuildUi();
                  }
                },
                trailing: const Icon(Icons.add),
                foregroundColor: ColorManager.white,
                backgroundColor: Theme.of(context).primaryColor,
                radius: 20.r,
              ),
            )
        ],
      ),
    );
  }
}
