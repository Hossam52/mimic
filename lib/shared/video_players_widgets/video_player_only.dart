import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/video_models/video.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class VideoPlayerOnly extends StatefulWidget {
  final Story video;
  const VideoPlayerOnly({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  State<VideoPlayerOnly> createState() => _VideoPlayerOnlyState();
}

class _VideoPlayerOnlyState extends State<VideoPlayerOnly> {
  @override
  void initState() {
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.video.videoUrl,
      placeholder: cachedNetworkImage(
          imageUrl: widget.video.thumNailUrl, height: 400.h, width: 1.sw),
    );

    widget.video.controller = BetterPlayerController(
      const BetterPlayerConfiguration(
        expandToFill: true,
        fit: BoxFit.cover,
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
    widget.video.controller.setupDataSource(dataSource);
    super.initState();
  }

  @override
  void dispose() {
    widget.video.controller.dispose();
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
      child: BetterPlayer(controller: widget.video.controller),
    );
  }
}
