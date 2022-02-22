import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/defulat_button.dart';

class MyRank extends StatelessWidget {
  const MyRank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Wrap(
            spacing: 5.w,
            children: [
              _RankItem(
                title: 'MIMIC JUNIOR',
                description: 'Words goes here',
                color: ColorManager.achievedRank,
              ),
              _RankItem(
                title: 'MIMIC LORD',
                description: 'Words goes here',
                color: ColorManager.achievedRank,
              ),
              const _RankItem(
                title: 'MIMIC KING',
                description: 'Words goes here',
              ),
            ],
          ),
          SizedBox(height: 35.h),
          Text(
            'Congratulations !! ',
            style: getSemiBoldStyle(fontSize: FontSize.s18),
          ),
          Text(
            'You have reached to MIMIC LORD Rank',
            style: getRegularStyle(),
          ),
          SizedBox(height: 60.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.0.w),
            child: DefaultButton(
                text: 'View All Ranks',
                onPressed: () {
                  navigateTo(context, Routes.allRanks);
                },
                padding: const EdgeInsets.symmetric(horizontal: 15),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: ColorManager.white,
                radius: 16.r),
          )
        ],
      ),
    );
  }
}

class _RankItem extends StatelessWidget {
  const _RankItem(
      {Key? key, this.color, required this.title, required this.description})
      : super(key: key);
  final Color? color;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    final rank = Center(
        child: Column(
      children: [
        Expanded(
          flex: 4,
          child: SvgPicture.asset('assets/images/crown.svg',
              width: 90.w, height: 90.w),
        ),
        Expanded(child: Text(title, style: getSemiBoldStyle())),
        Expanded(
          child: Text(
            description,
            style: getRegularStyle(fontSize: FontSize.s8),
          ),
        )
      ],
    ));
    return SizedBox(
      height: 135.h,
      width: 110.w,
      child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: color ?? ColorManager.unAchievedRank,
          ),
          child: color == null ? _stack(rank) : rank),
    );
  }

  Widget _stack(Widget rank) {
    return Stack(
      children: [
        rank,
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: color ?? ColorManager.unAchievedRank,
          ),
        )
      ],
    );
  }
}
