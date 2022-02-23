import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class ProfileStatistics extends StatelessWidget {
  const ProfileStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final divider = VerticalDivider(
      thickness: 2,
      color: ColorManager.black,
      indent: 22,
    );
    return IntrinsicHeight(
      child: Row(children: [
        const Expanded(
          child: FittedBox(
              // flex: 2,
              child: _ProfileStatisticsItem(
            count: '140',
            icon: MimicIcons.video,
            label: 'Video uploaded',
          )),
        ),
        divider,
        const Expanded(
          child: FittedBox(
              child: _ProfileStatisticsItem(
            count: '140',
            icon: MimicIcons.like,
            label: 'Likes',
          )),
        ),
        divider,
        const Expanded(
          child: FittedBox(
              // flex: 2,
              child: _ProfileStatisticsItem(
            count: '24K',
            icon: MimicIcons.contribution,
            label: 'Contribution',
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
