
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/home/stories/manage_stories_cubit/manage_stories_cubit.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/cubits/helper_cubit/helper_cubit.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';
import 'package:mimic/widgets/loading_brogress.dart';
import '../../modules/home/stories/models/story.dart';

class VideoPlayerStoryFriend extends StatefulWidget {
  final Story story;
  final PageController pageController;
  final int length;
  final ManageStoriesCubit manageStoriesCubit;
  const VideoPlayerStoryFriend({
    Key? key,
    required this.story,
    required this.pageController,
    required this.length,
    required this.manageStoriesCubit,
  }) : super(key: key);

  @override
  State<VideoPlayerStoryFriend> createState() => _VideoPlayerStoryFriendState();
}

class _VideoPlayerStoryFriendState extends State<VideoPlayerStoryFriend> {
  late BetterPlayerController betterPlayerController;
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
        fit: BoxFit.contain,
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
            if (widget.length == widget.pageController.page!.toInt()) {
              Navigator.pop(context);
            } else {
              widget.pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInExpo);
            }
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
        if (_helperCubit != null && !_helperCubit!.isClosed) {
          _helperCubit!.rebuildPart();
        }
      }
    });
    widget.manageStoriesCubit.viewStory(widget.story.id);
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
    return Stack(
      children: [
        BetterPlayer(controller: betterPlayerController),
        BlocBuilder<HelperCubit, HelperState>(
          buildWhen: (_, state) => state is HelperRebuild,
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
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: 5.w,
            top: 15.h,
          ),
          child: SizedBox(
            height: 40.h,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(
                  color: ColorManager.white,
                ),
                SizedBox(
                  width: 5.w,
                ),
                cachedNetworkImageProvider(widget.story.user.image, 22.r),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  widget.story.user.name,
                  style: getMediumStyle(color: ColorManager.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
