import 'dart:developer';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/shared/cubits/helper_cubit/helper_cubit.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/widgets/loading_brogress.dart';

import '../../modules/home/stories/models/story.dart';

class VideoPlayerStory extends StatefulWidget {
  final Story story;
  const VideoPlayerStory({
    Key? key,
    required this.story,
  }) : super(key: key);

  @override
  State<VideoPlayerStory> createState() => _VideoPlayerStoryState();
}

class _VideoPlayerStoryState extends State<VideoPlayerStory> {
  late BetterPlayerController betterPlayerController;
  late ModalRoute modalRoute;
  HelperCubit? _helperCubit;
  @override
  void initState() {
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.story.storyUrl,
      placeholder: cachedNetworkImage(
          imageUrl: widget.story.thumbNail, height: 400.h, width: 1.sw),
    );

    betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        expandToFill: true,
        fit: BoxFit.cover,
        aspectRatio: 1,
        autoPlay: true,

        showPlaceholderUntilPlay: true,
        fullScreenAspectRatio: 1,
        //fullScreenByDefault: true,
        deviceOrientationsOnFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown
        ],
        //startAt: Duration(seconds: 0),

        eventListener: (event) {
          if (event.betterPlayerEventType.name ==
              BetterPlayerEventType.finished.name) {
            Navigator.pop(context);
          }
          return;
        },
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          enableSubtitles: false,
          enableFullscreen: false,
          enableQualities: false,
          enablePlayPause: false,
          enableAudioTracks: false,
          enableSkips: false,
          enablePlaybackSpeed: false,
          showControls: false,

          //  backgroundColor: Colors.pink,
          controlBarColor: Colors.transparent,

          ///   playIcon: ,
          loadingWidget: LoadingProgress(),
        ),
      ),
    );

    betterPlayerController.setupDataSource(dataSource);

    betterPlayerController.videoPlayerController!.addListener(() {
      // log(betterPlayerController
      //     .videoPlayerController!.value.duration!.inSeconds
      //     .toString());
      // log(betterPlayerController.videoPlayerController!.value.position.inSeconds
      //     .toString());
      if (mounted) {
        if (modalRoute.isCurrent) {
          if (!betterPlayerController.isPlaying()!)
            betterPlayerController.videoPlayerController!.play();

          log('IsCurrent');
        } else {
          if (betterPlayerController.isPlaying()!) 
          {
            betterPlayerController.pause();
          }
        }

        if (betterPlayerController.isPlaying()!&&_helperCubit != null && !_helperCubit!.isClosed) {
          _helperCubit!.rebuildPart();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    betterPlayerController.dispose();
    // log(betterPlayerController.videoPlayerController.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    modalRoute = ModalRoute.of(context)!;
    return Stack(
      children: [
        BetterPlayer(controller: betterPlayerController),
        BlocBuilder<HelperCubit, HelperState>(
          builder: (context, state) {
            _helperCubit = HelperCubit.get(context);
            return LinearProgressIndicator(
              backgroundColor: ColorManager.primary,
              color: ColorManager.white,
              value: betterPlayerController
                          .videoPlayerController!.value.duration ==
                      null
                  ? 0
                  : ((betterPlayerController.videoPlayerController!.value
                          .position.inMicroseconds) /
                      (betterPlayerController.videoPlayerController!.value
                          .duration!.inMicroseconds)),
            );
          },
        ),
      ],
    );
  }
}
