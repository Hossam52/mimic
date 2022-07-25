
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
  AllRanksScreen({Key? key}) : super(key: key);
  final ScrollController controller = ScrollController();
  final _rankItemHeight = 120.h;
  late final double _halfRankItem = _rankItemHeight / 2;
  final _marginAfterStatistics = 20.h;
  final _rankItemMargin = 8.h;
  late final double _totalItemMarginVertical = _rankItemMargin * 2;
  final double _statisticsHeight = 130.h;
  @override
  Widget build(BuildContext context) {
    const rankItems = 5;

    return Scaffold(
      appBar: const TransparentAppBar(
        title: 'All Ranks',
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SizedBox(
                      height: _statisticsHeight,
                      child: const Center(child: _MyRankDetails())),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 16.w),
                  child: Column(
                    children: [
                      SizedBox(height: _marginAfterStatistics),
                      for (int i = 0; i < rankItems; i++)
                        _RankItem(
                            rankItemMargin: _rankItemMargin,
                            rankItemHeight: _rankItemHeight,
                            title: 'MIMIC JUNIOR',
                            description: 'Description goes here'),
                    ],
                  ),
                ),
              ],
            ),
            _timeLine(rankItems, 3),
          ],
        ),
      ),
    );
  }

  Widget _timeLine(int rankItems, int currentRank) {
    return Builder(
      builder: (context) {
        return TimelineTheme(
          data: TimelineTheme.of(context).copyWith(
              color: Theme.of(context).primaryColor,
              connectorTheme:
                  ConnectorTheme.of(context).copyWith(thickness: 3)),
          child: Timeline.tileBuilder(
            shrinkWrap: true,
            controller: controller,
            builder: TimelineTileBuilder.connected(
              firstConnectorBuilder: (context) => SolidLineConnector(
                indent: _statisticsHeight /
                    2, //to hide the top part that is appear above the statistic box
              ),
              indicatorBuilder: (_, index) =>
                  _indicatorImage(index, currentRank),
              indicatorPositionBuilder: (context, index) => 1,
              itemExtentBuilder: _itemExtent,
              connectorBuilder: (context, _, __) => const SolidLineConnector(),
              nodePositionBuilder: (_, index) => 0.05,
              itemCount: rankItems,
            ),
          ),
        );
      },
    );
  }

  double _itemExtent(BuildContext context, int index) {
    //here we make height for each connector and the first one is equal to height of statistical item + the margin after it + margin between rank item + half of rank item to center the image
    if (index == 0) {
      // return 130.h + 20.h + 8.h + 50.h;
      return (_statisticsHeight +
          _marginAfterStatistics +
          _rankItemMargin +
          _halfRankItem);
    } else {
      //otherwise we assume that all ranks will be the same height so all will be the smae height equal to half of rank item height (above)+ totalMargin(margin*2 as one for the top one and the other for the next one) + half of rank item to be centered
      // return 116.h;
      return _halfRankItem + _totalItemMarginVertical + _halfRankItem;
    }
  }

  Widget _indicatorImage(int index, int currentRank) {
    if (index < currentRank) {
      return Stack(
        alignment: Alignment.center,
        children: [
          _rankStatus('assets/images/achieved_rank.svg'),
          _rankStatus('assets/images/done.svg', 19),
        ],
      );
    } else if (index == currentRank) {
      return _rankStatus('assets/images/current_rank.svg');
    } else {
      return _rankStatus('assets/images/locked_rank.svg');
    }
  }

  Widget _rankStatus(String imagePath, [double? size]) {
    return SvgPicture.asset(
      imagePath,
      width: size?.r ?? 25.r,
      height: size?.r ?? 25.r,
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
  const _RankItem(
      {Key? key,
      required this.title,
      required this.description,
      required this.rankItemMargin,
      required this.rankItemHeight})
      : super(key: key);
  final String title;
  final String description;
  final double rankItemMargin;
  final double rankItemHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: rankItemMargin),
      height: rankItemHeight,
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
