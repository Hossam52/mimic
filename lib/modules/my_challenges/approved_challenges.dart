import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/modules/my_challenges/widgets/all_categories_drop_down.dart';
import 'package:mimic/modules/my_challenges/widgets/my_challenge_item.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/play_video_icon.dart';
import 'package:mimic/widgets/rounded_image.dart';

class ApprovedChallenges extends StatelessWidget {
  const ApprovedChallenges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          const AllCategoriesDropDown(),
          Expanded(child: _requestsListView()),
        ],
      ),
    );
  }

  Widget _requestsListView() {
    return ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return MyChallengeItem(
            displayBlackOpacity: index != 0,
          );
          return _ApprovedItem(
            remaining: index != 0,
          );
        });
  }
}

class _ApprovedItem extends StatelessWidget {
  const _ApprovedItem({Key? key, this.remaining = false}) : super(key: key);
  final bool remaining;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: SizedBox(
        height: 270.h,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Center(child: _ChallengePerson()),
                    const Spacer(),
                    Text(
                      '#Music',
                      style: getBoldStyle(
                        color: ColorManager.visibilityColor,
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: _Video(
                  remaining: remaining,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChallengePerson extends StatelessWidget {
  const _ChallengePerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedImage(imagePath: 'assets/images/static/avatar.png', size: 27.w),
        SizedBox(width: 10.w),
        Text(
          'Rahma Ahmed',
          style: getBoldStyle(fontSize: FontSize.s14),
        )
      ],
    );
  }
}

class _Video extends StatelessWidget {
  const _Video({Key? key, this.remaining = false}) : super(key: key);
  final bool remaining;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/static/video_preview.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          if (remaining) const BlackOpacity(opacity: 0.4),
          Align(alignment: Alignment.topLeft, child: _challengeNameAndTime()),
          if (remaining)
            Align(alignment: Alignment.bottomLeft, child: _remainingTime()),
          Align(child: PlayVideoIcon(size: 40.w))
        ],
      ),
    );
  }

  Widget _challengeNameAndTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Challenge Name',
              style: getSemiBoldStyle(color: ColorManager.white),
            ),
            Text(
              '2Min Ago',
              style: getRegularStyle(color: ColorManager.timeAgo),
            )
          ]),
    );
  }

  Widget _remainingTime() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '2 days, 10 hours, 12 min',
        style: getBoldStyle(fontSize: FontSize.s14, color: ColorManager.white),
      ),
    );
  }
}
