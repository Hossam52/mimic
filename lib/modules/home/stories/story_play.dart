import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/video_models/video.dart';
import 'package:mimic/modules/home/stories/models/story.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class StoryPlay extends StatefulWidget {
  final Story story;
  const StoryPlay({
    Key? key,
    required this.story,
  }) : super(key: key);

  @override
  State<StoryPlay> createState() => _StoryPlayState();
}

class _StoryPlayState extends State<StoryPlay> {
  late BetterPlayerController _betterPlayerController;
  @override
  void initState() {
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.story.storyUrl,
      placeholder: cachedNetworkImage(
          imageUrl: widget.story.thumbNail, height: 0.8.sh, width: 1.sw),
    );
    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        expandToFill: true,
        autoPlay: true,

        fit: BoxFit.cover,
        aspectRatio: 1,
        showPlaceholderUntilPlay: true,
        //fullScreenByDefault: true,
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
          enablePlayPause: false,

          enableProgressBar: false,
          enableQualities: false,
          enableRetry: false,

          //  backgroundColor: Colors.pink,
          controlBarColor: Colors.transparent,

          ///   playIcon: ,
          loadingWidget: LoadingProgress(),
        ),
      ),
    );
    _betterPlayerController.setupDataSource(dataSource);
    super.initState();
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
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
      height: 1.sh,
      child: BetterPlayer(controller: _betterPlayerController),
    );
  }
}
