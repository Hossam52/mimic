import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:timelines/timelines.dart';

class AllRanksScreen extends StatelessWidget {
  const AllRanksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        title: 'All Ranks',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _MyRankDetails(),
              SizedBox(height: 20.h),
              _RankItem(
                  title: 'MIMIC JUNIOR', description: 'Description goes here'),
              _RankItem(
                  title: 'MIMIC JUNIOR', description: 'Description goes here'),
              _RankItem(
                  title: 'MIMIC JUNIOR', description: 'Description goes here'),
              _RankItem(
                  title: 'MIMIC JUNIOR', description: 'Description goes here'),

              // Expanded(
              //   child: Timeline.tileBuilder(
              //     scrollDirection: Axis.vertical,
              //     builder: TimelineTileBuilder(
              //       indicatorBuilder: (_, index) {
              //         return SizedBox(
              //           height: 40.0,
              //           child: SolidLineConnector(),
              //         );
              //       },
              //       itemCount: 5,
              //       contentsBuilder: (_, index) {
              //         // ContainerIndicator(child: ,)
              //         return Text(index.toString());
              //       },
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class _MyRankDetails extends StatelessWidget {
  const _MyRankDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            const Expanded(
                child: _RankStatisticItem(
              icon: MimicIcons.star,
              title: 'YOUR POINTS',
              count: '590',
            )),
            VerticalDivider(
              thickness: 1,
              color: ColorManager.white,
              indent: 16.h,
              endIndent: 16.h,
            ),
            const Expanded(
                child: _RankStatisticItem(
              icon: MimicIcons.localRank,
              title: 'LOCAL RANK',
              count: '#56',
            )),
          ],
        ),
      ),
    );
  }
}

class _RankStatisticItem extends StatelessWidget {
  const _RankStatisticItem(
      {Key? key, required this.icon, required this.title, required this.count})
      : super(key: key);
  final IconData icon;
  final String title;
  final String count;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 22.r, color: ColorManager.allRanksStatisticItem),
          Text(
            title,
            style: getMediumStyle(
              color: ColorManager.white.withOpacity(0.5),
            ),
          ),
          Text(
            count,
            style:
                getBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
          )
        ],
      ),
    );
  }
}

class _RankItem extends StatelessWidget {
  const _RankItem({Key? key, required this.title, required this.description})
      : super(key: key);
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: ColorManager.selectedColor),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 50.w),
                  child: Text(title,
                      style: getSemiBoldStyle(fontSize: FontSize.s14)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 65.w),
                  child: Text(description, style: getRegularStyle()),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.w),
            child: SvgPicture.asset('assets/images/crown.svg',
                width: 92.w, height: 92.h),
          ),
        ],
      ),
    );
  }
}
