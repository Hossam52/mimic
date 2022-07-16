import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/challenges/challange_data_cubit/challange_data_cubit.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/widgets/video_statistic_item.dart';

class VideoStatistics extends StatelessWidget {
  const VideoStatistics({Key? key,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
  final ChallangeDataCubit challangeDataCubit=ChallangeDataCubit.get(context);

    return Wrap(spacing: 10.h, children: [
      FavoriteIcon(
          count: challangeDataCubit.challangeDetails.likesNumber.toString(),
          textColor: ColorManager.black),
      CommentIcon(
        count: challangeDataCubit.challangeDetails.commentsNumber.toString(),
        textColor: ColorManager.black,
        onPressed: () {
          Dialogs.showCommentsDialog(context,3);
        },
      ),
      ViewIcon(
        count: challangeDataCubit.challangeDetails.views.toString(),
        textColor: ColorManager.black,
        iconColor: ColorManager.commentsColor,
      ),
      ShareIcon(
          count: challangeDataCubit.challangeDetails.shareCount,
          textColor: ColorManager.black),
    ]);
  }
}