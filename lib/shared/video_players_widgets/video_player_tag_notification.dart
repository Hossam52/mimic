import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/video_models/abstract_video_model.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class VideoPlayerOnlyTagNotification extends StatefulWidget {
  final AbstractVideoModel video;
  const VideoPlayerOnlyTagNotification({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  State<VideoPlayerOnlyTagNotification> createState() =>
      _VideoPlayerOnlyTagNotificationState();
}

class _VideoPlayerOnlyTagNotificationState
    extends State<VideoPlayerOnlyTagNotification> {
  late BetterPlayerController controller;

  @override
  void initState() {
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.video.videoUrl,
      placeholder: cachedNetworkImage(
          imageUrl: widget.video.thumbNail, height: 400.h, width: 1.sw),
    );

    controller = BetterPlayerController(
      const BetterPlayerConfiguration(
        expandToFill: true,
        fit: BoxFit.contain,
        aspectRatio: 1,
        showPlaceholderUntilPlay: true,
        fullScreenAspectRatio: 1,
        deviceOrientationsOnFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown
        ],
        //startAt: Duration(seconds: 0),

        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableSubtitles: false,
          enableAudioTracks: false,
          enableSkips: false,
          //  backgroundColor: Colors.pink,
          controlBarColor: Colors.transparent,

          ///   playIcon: ,
          loadingWidget: LoadingProgress(),
        ),
      ),
    );
    controller.setupDataSource(dataSource);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        // color: ColorManager.primary
      ),
      height: 400.h,
      child: BetterPlayer(controller: controller),
    );
  }
}
