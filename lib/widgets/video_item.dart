import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/widgets/person_details.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/widgets/play_video_icon.dart';
import 'package:mimic/widgets/video_statistic_item.dart';

class VideoOverview extends StatelessWidget {
  const VideoOverview({Key? key, this.defaultIconColor}) : super(key: key);
  final Color? defaultIconColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/static/video_preview.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          const BlackOpacity(
            opacity: 0.37,
          ),
          PlayVideoIcon(size: 66.r),
          Align(alignment: Alignment.topLeft, child: const PersonDetails()),
          Align(
              alignment: Alignment.bottomLeft,
              child: _challengeActions(context)),
        ],
      ),
    );
  }

  Widget _challengeActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 10.w,
        children: [
          const FavoriteIcon(
            count: '12',
          ),
          CommentIcon(
            count: '15',
            onPressed: () {
              Dialogs.showCommentsDialog(context);
            },
          ),
          ViewIcon(count: '112', iconColor: defaultIconColor),
        ],
      ),
    );
  }
}
