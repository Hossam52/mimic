import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/hashtag_item.dart';
import 'package:mimic/widgets/play_video_icon.dart';
import 'package:mimic/widgets/rounded_image.dart';

class MyChallengeItem extends StatelessWidget {
  const MyChallengeItem(
      {Key? key, this.stackItems = const [], this.displayBlackOpacity = true})
      : super(key: key);
  final List<Widget> stackItems;
  final bool displayBlackOpacity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: SizedBox(
        height: 220.h,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: const [
                    Center(child: _ChallengePerson()),
                    Spacer(),
                    HashtagItem(title: 'Music'),
                  ],
                ),
                Expanded(
                    child: _Video(
                        stackItems: stackItems,
                        displayBlackOpacity: displayBlackOpacity)),
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
          style: getBoldStyle(fontSize: FontSize.s12),
        )
      ],
    );
  }
}

class _Video extends StatelessWidget {
  const _Video(
      {Key? key, required this.stackItems, required this.displayBlackOpacity})
      : super(key: key);
  final List<Widget> stackItems;
  final bool displayBlackOpacity;
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
          if (displayBlackOpacity) const BlackOpacity(opacity: 0.4),
          Align(alignment: Alignment.topLeft, child: _challengeNameAndTime()),
          ...stackItems,
          Align(
            child: PlayVideoIcon(
              size: 40.w,
            ),
          )
        ],
      ),
    );
  }

  Widget _challengeNameAndTime() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 4.w),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Challenge Name',
              style: getSemiBoldStyle(
                  color: ColorManager.white, fontSize: FontSize.s10),
            ),
            Text(
              '2Min Ago',
              style: getRegularStyle(
                  color: ColorManager.timeAgo, fontSize: FontSize.s8),
            )
          ]),
    );
  }
}
