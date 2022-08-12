import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/video_models/abstract_video_model.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/shared/video_players_widgets/video_player_tag_notification.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/widgets/play_video_icon.dart';

class ThumbNailVideoAction extends StatelessWidget {
  const ThumbNailVideoAction({Key? key, required this.video}) : super(key: key);
  final AbstractVideoModel video;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: double.maxFinite,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: InkWell(
        onTap: () async {
          showDialog(
            context: context,
            builder: (context) => Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                child: VideoPlayerOnlyTagNotification(video: video)),
          );
        },
        child: Stack(
          children: [
            cachedNetworkImage(
              imageUrl: video.thumbNail,
              height: double.maxFinite,
              width: double.maxFinite,
            ),

            // PersonDetails(),
            const BlackOpacity(opacity: 0.4),
            const Center(child: PlayVideoIcon()),
          ],
        ),
      ),
    );
  }
}
