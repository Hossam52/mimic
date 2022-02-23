import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/main.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/widgets/hashtag_item.dart';
import 'package:mimic/widgets/person_details.dart';
import 'package:mimic/widgets/play_video_icon.dart';
import 'package:mimic/widgets/profile_statistics.dart';
import 'package:mimic/widgets/rounded_image.dart';
import 'package:mimic/widgets/video_item.dart';
import 'package:mimic/widgets/video_statistic_item.dart';

class ChallengerProfile extends StatelessWidget {
  const ChallengerProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: getBoldStyle(fontSize: FontSize.s14),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: BackButton(color: ColorManager.commentsColor),
        actions: [
          GestureDetector(
            onTap: () {
              Dialogs.showQrSaveShare(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SvgPicture.asset('assets/images/scan_qr.svg',
                  color: ColorManager.commentsColor, width: 24.w, height: 24.w),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            children: [
              const _ProfileInfo(),
              SizedBox(height: 25.h),
              const ProfileStatistics(),
              SizedBox(height: 32.h),
              const _Rank(),
              SizedBox(height: 40.h),
              const _JoinedAndCreatedRowButtons(),
              SizedBox(height: 24.h),
              _videos()
            ],
          ),
        ),
      ),
    );
  }

  Widget _videos() {
    return ListView.separated(
      separatorBuilder: (_, index) => SizedBox(height: 16.h),
      shrinkWrap: true,
      primary: false,
      itemBuilder: (_, index) => const _VideoOverview(),
      itemCount: 10,
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedImage(
          imagePath: 'assets/images/static/avatar.png',
          size: 65.r,
        ),
        SizedBox(width: 8.w),
        Column(
          children: [
            Text(
              'Maria Snow',
              style: getRegularStyle(
                      fontSize: FontSize.s14, color: ColorManager.profileName)
                  .copyWith(
                      fontFamily: FontConstants.gibsonFamily,
                      fontWeight: FontWeight.w500),
            ),
            Text(
              'San Francisco, CA',
              style: getRegularStyle(
                      fontSize: FontSize.s9,
                      color: ColorManager.profileLocation)
                  .copyWith(fontFamily: FontConstants.gibsonFamily),
            ),
          ],
        )
      ],
    );
  }
}

class _Rank extends StatelessWidget {
  const _Rank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.h),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Rank', style: getBoldStyle(fontSize: FontSize.s18)),
                Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Text('Rank 2', style: getBoldStyle(fontSize: 14)),
                ),
                SizedBox(height: 10.h),
                RatingBarIndicator(
                  itemBuilder: (_, index) {
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 22.r,
                    );
                  },
                  rating: 5,
                  itemCount: 5,
                  itemSize: 22.r,
                ),
              ],
            ),
            const Spacer(),
            SvgPicture.asset(
              'assets/images/crown.svg',
              width: 100.w,
              height: 100.w,
            )
          ],
        ),
      ),
    );
  }
}

class _JoinedAndCreatedRowButtons extends StatefulWidget {
  const _JoinedAndCreatedRowButtons({Key? key}) : super(key: key);

  @override
  State<_JoinedAndCreatedRowButtons> createState() =>
      _JoinedAndCreatedRowButtonsState();
}

class _JoinedAndCreatedRowButtonsState
    extends State<_JoinedAndCreatedRowButtons> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          GestureDetector(
            onTap: () => setState(() {
              selected = 0;
            }),
            child: Text('Joined',
                style: getSemiBoldStyle(
                    fontSize: FontSize.s20,
                    color: selected == 0
                        ? ColorManager.visibilityColor
                        : ColorManager.commentsColor)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: VerticalDivider(
                thickness: 2, color: ColorManager.commentsColor),
          ),
          GestureDetector(
            onTap: () => setState(() {
              selected = 1;
            }),
            child: Text('Joined',
                style: getSemiBoldStyle(
                    fontSize: FontSize.s20,
                    color: selected == 1
                        ? ColorManager.visibilityColor
                        : ColorManager.commentsColor)),
          ),
        ],
      ),
    );
  }
}

class _VideoOverview extends StatelessWidget {
  const _VideoOverview({Key? key, this.defaultIconColor, this.borderRadius})
      : super(key: key);
  final Color? defaultIconColor;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.h,
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius ?? 6.r)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  getVideoImageRandom(),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
                const BlackOpacity(
                  opacity: 0.37,
                ),
                PlayVideoIcon(size: 66.r),
                const Align(
                    alignment: Alignment.topLeft, child: PersonDetails()),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.volume_mute,
                        color: ColorManager.white,
                        size: 30.r,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.all(10.h),
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: HashtagItem(title: 'Football'),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              _challengeActions(context),
              const Spacer(),
              Icon(
                Icons.more_vert,
                size: 20.r,
                color: ColorManager.grey,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _challengeActions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.h),
      child: Wrap(
        spacing: 10.w,
        children: [
          FavoriteIcon(
            count: '12',
            textColor: ColorManager.black,
          ),
          CommentIcon(
            count: '15',
            textColor: ColorManager.black,
            onPressed: () {
              Dialogs.showCommentsDialog(context);
            },
          ),
          ViewIcon(
            count: '112',
            textColor: ColorManager.black,
            iconColor: ColorManager.commentsColor,
          ),
        ],
      ),
    );
  }
}
