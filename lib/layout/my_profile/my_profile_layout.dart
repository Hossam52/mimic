import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/layout/widgets/tab_bar_header.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/modules/my_profile/my_rank.dart';
import 'package:mimic/modules/my_profile/my_videos.dart';
import 'package:mimic/modules/my_profile/profile_my_challenges.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/play_video_icon.dart';
import 'package:mimic/widgets/rounded_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/widgets/video_item.dart';
import 'package:mimic/widgets/video_statistic_item.dart';

final List<CustomTabBarItem> _profileTabs = [
  CustomTabBarItem(name: 'My videos', widget: const MyVideos()),
  CustomTabBarItem(name: 'MyRank', widget: const MyRank()),
  CustomTabBarItem(name: 'My challenges', widget: const ProfileMyChallenges()),
];

class MyProfileLayout extends StatelessWidget {
  const MyProfileLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final divider = VerticalDivider(
      thickness: 2,
      color: ColorManager.black,
      indent: 22,
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: DefaultTabController(
            length: _profileTabs.length,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _MyProfileDetails(),
                SizedBox(height: 22.h),
                IntrinsicHeight(
                  child: Row(children: [
                    const FittedBox(
                        // flex: 2,
                        child: _ProfileStatistics(
                      count: '140',
                      icon: MimicIcons.video,
                      label: 'Video uploaded',
                    )),
                    divider,
                    const FittedBox(
                        child: _ProfileStatistics(
                      count: '140',
                      icon: MimicIcons.like,
                      label: 'Likes',
                    )),
                    divider,
                    const FittedBox(
                        // flex: 2,
                        child: _ProfileStatistics(
                      count: '24K',
                      icon: MimicIcons.contribution,
                      label: 'Contribution',
                    )),
                  ]),
                ),
                SizedBox(height: 36.h),
                TabBarHeader(
                  fontSize: FontSize.s14,
                  tabBars: _profileTabs,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: TabBarView(
                        children: _profileTabs.map((e) => e.widget).toList()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MyProfileDetails extends StatelessWidget {
  const _MyProfileDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 100.r,
          child: Stack(
            children: [
              RoundedImage(
                imagePath: 'assets/images/static/avatar.png',
                size: 95.r,
              ),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: SvgPicture.asset(
              //     'assets/images/crown_rotated.svg',
              //     width: 44.w,
              //     height: 44.w,
              //     fit: BoxFit.fill,
              //   ),
              // )
            ],
          ),
        ),
        Row(
          children: [
            const Spacer(),
            Column(
              children: [
                Text(
                  'Maria Snow',
                  style: getRegularStyle(
                          fontSize: FontSize.s24,
                          color: ColorManager.profileName)
                      .copyWith(
                          fontFamily: FontConstants.gibsonFamily,
                          fontWeight: FontWeight.w500),
                ),
                Text(
                  'San Francisco, CA',
                  style: getRegularStyle(
                          fontSize: FontSize.s16,
                          color: ColorManager.profileLocation)
                      .copyWith(fontFamily: FontConstants.gibsonFamily),
                ),
              ],
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _scanQR(),
                SizedBox(width: 19.w),
                _settings(context),
                SizedBox(width: 19.w),
              ],
            ))
          ],
        ),
      ],
    );
  }

  Widget _scanQR() {
    return SvgPicture.asset(
      'assets/images/scan_qr.svg',
      fit: BoxFit.fill,
      width: 19.w,
      height: 19.w,
      color: ColorManager.commentsColor,
    );
  }

  Widget _settings(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, Routes.profileSettings);
      },
      child: SvgPicture.asset(
        'assets/images/settings.svg',
        fit: BoxFit.fill,
        width: 19.w,
        height: 19.w,
        color: ColorManager.black,
      ),
    );
  }
}

class _ProfileStatistics extends StatelessWidget {
  const _ProfileStatistics(
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
