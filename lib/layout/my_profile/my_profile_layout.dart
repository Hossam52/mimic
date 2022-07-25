
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/layout/widgets/tab_bar_header.dart';
import 'package:mimic/models/user_model/user.dart';
import 'package:mimic/modules/my_profile/my_rank.dart';
import 'package:mimic/modules/my_profile/my_videos.dart';
import 'package:mimic/modules/my_profile/profile_cubit/profile_cubit.dart';
import 'package:mimic/modules/my_profile/profile_my_challenges.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';
import 'package:mimic/widgets/custom_nested_scroll_view.dart';
import 'package:mimic/widgets/loading_brogress.dart';
import 'package:mimic/widgets/profile_statistics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final List<CustomTabBarItem> _profileTabs = [
  CustomTabBarItem(name: 'My videos', widget: const Text('')),
  CustomTabBarItem(name: 'My Rank', widget: const MyRank()),
  CustomTabBarItem(name: 'My challenges', widget: const ProfileMyChallenges()),
];

class MyProfileLayout extends StatelessWidget {
  const MyProfileLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is! ProfileGetAllDataLoading &&
                state is! ProfileGetAllDataError) {
              var cubit = ProfileCubit.get(context);
              return Padding(
                padding: EdgeInsets.all(AppPadding.p15.r),
                child: DefaultTabController(
                  length: _profileTabs.length,
                  child: CustomNestedScrollView(
                  
                    headerWidgets: 
                    [
                      _MyProfileDetails(user: cubit.userModel.user),
                      SizedBox(height: AppSize.s22.h),
                       ProfileStatistics(staticticsData: cubit.userModel.staticticsData),
                      SizedBox(height: AppSize.s36.h),
                      TabBarHeader(
                        fontSize: FontSize.s12,
                        tabBars: _profileTabs,
                      ),
                    ],
                    body: Padding(
                      padding: EdgeInsets.only(top: AppPadding.p15.h),
                      child: TabBarView(children: [
                        MyVideos(videos: cubit.videosModel.videos),
                        const MyRank(),
                        const ProfileMyChallenges(),
                      ]
                          //   _profileTabs.map((e) => e.widget).toList()
                          ),
                    ),
                  ),
                ),
              );
            } else {
              return const LoadingProgressSearchChallanges();
            }
          },
        ),
      ),
    );
  }
}

class _MyProfileDetails extends StatelessWidget {
  final User user;
  const _MyProfileDetails({required this.user});
  @override
  Widget build(BuildContext context) {
    final imageSize = 90.w;
    final crownSize = imageSize / 2;

    return RefreshIndicator(
      onRefresh: () => ProfileCubit.get(context).getProfileAllData(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              width: imageSize,
              height: imageSize,
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: crownSize / 2),
                      child: cachedNetworkImageProvider(
                          user.image, imageSize - crownSize / 2),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: SvgPicture.asset(
                      'assets/images/crown_rotated.svg',
                      height: crownSize,
                      width: crownSize,
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                const Spacer(),
                Column(
                  children: [
                    Text(
                      user.name,
                      style: getRegularStyle(
                              fontSize: FontSize.s24,
                              color: ColorManager.profileName)
                          .copyWith(
                              fontFamily: FontConstants.gibsonFamily,
                              fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${user.city}, ${user.country}',
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
                    _scanQR(context),
                    SizedBox(width: 19.w),
                    _settings(context),
                    SizedBox(width: 19.w),
                  ],
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _scanQR(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Dialogs.shareSaveToGalleryDialog(context);
      },
      child: SvgPicture.asset(
        'assets/images/scan_qr.svg',
        fit: BoxFit.fill,
        width: 19.w,
        height: 19.w,
        color: ColorManager.commentsColor,
      ),
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
