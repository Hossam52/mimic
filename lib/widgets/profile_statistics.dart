import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/user_model/staticticsData.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class ProfileStatistics extends StatelessWidget {
  const ProfileStatistics({Key? key, this.staticticsData}) : super(key: key);
  final StaticticsData? staticticsData;
  @override
  Widget build(BuildContext context) {
    final divider = VerticalDivider(
      thickness: 2,
      color: ColorManager.black,
      indent: 22,
    );
    return IntrinsicHeight(
      child: Row(children: [
        Expanded(
          child: FittedBox(
              // flex: 2,
              child: _ProfileStatisticsItem(
            count: staticticsData!.numberOfVideos.toString(),
            icon: MimicIcons.video,
            label: AppStrings.videosUploaded.translateString(context),
          )),
        ),
        divider,
        Expanded(
          child: FittedBox(
              child: _ProfileStatisticsItem(
            count: staticticsData!.numberOfLikes.toString(),
            icon: MimicIcons.like,
            label: AppStrings.likes.translateString(context),
          )),
        ),
        divider,
        Expanded(
          child: FittedBox(
              // flex: 2,
              child: _ProfileStatisticsItem(
            count: staticticsData!.numberOfContrubtion.toString(),
            icon: MimicIcons.contribution,
            label: AppStrings.contribution.translateString(context),
          )),
        ),
      ]),
    );
  }
}

class _ProfileStatisticsItem extends StatelessWidget {
  const _ProfileStatisticsItem(
      {Key? key, required this.count, required this.icon, required this.label})
      : super(key: key);
  final String count;
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: getSemiBoldStyle(fontSize: FontSize.s20),
        ),
        Row(
          children: [
            Icon(icon, color: ColorManager.profileStatisticIcon, size: 15.r),
            SizedBox(width: 15.w),
            Text(
              label,
              style: getRegularStyle(),
            ),
          ],
        )
      ],
    );
  }
}
