import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/challenges/challange_data_cubit/challange_data_cubit.dart';
import 'package:mimic/modules/challenges/widgets/challenges_grid_view.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class ChallangersData extends StatelessWidget {
  const ChallangersData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChallengesGridView(context: context),
        ChallangeDataCubit.get(context).state is ChallangeDataLoading
            ? const LoadingProgress()
            : ChallangeDataCubit.get(context).videosModel.videos.links.next !=
                    null
                ? Padding(
                    padding: EdgeInsets.all(8.0.r),
                    child: Builder(builder: (context) {
                      return TextButton(
                        onPressed: () {
                          // log('get more videos');
                          ChallangeDataCubit cubit =
                              ChallangeDataCubit.get(context);
                          if (cubit.videosModel.videos.links.next != null) {
                            cubit.getMoreVideos();
                          }
                          // navigateTo(context, Routes.allChallengers);
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
                  )
                : Container(),
      ],
    );
  }
}
