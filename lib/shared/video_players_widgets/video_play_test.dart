
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/video_models/video.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/widgets/loading_brogress.dart';
import 'package:mimic/widgets/person_details.dart';
import 'package:mimic/widgets/video_statistic_item.dart';

class VideoItemPlayer extends StatefulWidget {
  final Story video;
  final List<Story> controller;
  const VideoItemPlayer(
      {Key? key, required this.video, required this.controller})
      : super(key: key);

  @override
  State<VideoItemPlayer> createState() => _VideoItemPlayerState();
}

class _VideoItemPlayerState extends State<VideoItemPlayer> {
  
  double itemSize = 350;
  
  Widget _challengeActions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: Wrap(
        spacing: 10.w,
        children: [
          FavoriteIcon(
            count: widget.video.likeNumber.toString(),
          ),
          CommentIcon(
            count: widget.video.commentNumber.toString(),
            onPressed: () {
              //  Dialogs.showCommentsDialog(context,3);
            },
          ),
          ViewIcon(
              count: widget.video.numberOfwatches.toString(),
              iconColor: ColorManager.white),
        ],
      ),
    );
  }

  @override
  void initState() {
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.video.videoUrl,
      placeholder: cachedNetworkImage(
          imageUrl: widget.video.thumNailUrl, height: 300.h, width: 1.sw),
    );
    widget.video.controller = BetterPlayerController(
      BetterPlayerConfiguration(
        eventListener: (event) {
          if (event.betterPlayerEventType == BetterPlayerEventType.play) {
            for (Story video in widget.controller) {
              if (video.id != widget.video.id &&
                  video.controller.hasCurrentDataSourceStarted &&
                  video.controller.isPlaying()!) {
                video.controller.pause();
              }
            }
          }
          //  log(event.betterPlayerEventType.toString());
        },

        // expandToFill: true,
        showPlaceholderUntilPlay: true,
        // fullScreenAspectRatio: 0.5,
        deviceOrientationsOnFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown
        ],
        //startAt: Duration(seconds: 0),

        overlay: SizedBox(
          height: itemSize.h,
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PersonDetails(user: widget.video.user),
                SizedBox(
                  height: 30.h,
                ),
                _challengeActions(context),
              ],
            ),
          ),
        ),
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          enableSubtitles: false,
          enableAudioTracks: false,
          enableSkips: false,

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
    return SizedBox(
      height: itemSize.h,
      child: Stack(
        children: [
          SizedBox(
            height: itemSize.h,
            child: BetterPlayer(controller: widget.video.controller),
          ),
        ],
      ),
    );
  }
}

class VideoPlayTest extends StatelessWidget {
  const VideoPlayTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        clipBehavior: Clip.antiAlias,
        height: 300.h,
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Stack(
          children: [
            SizedBox(
              height: 300.h,
              child: BetterPlayer.network(
                "https://royalmazad.com/public/mimic/public/videos/1650881675648.m3u8",
                betterPlayerConfiguration: BetterPlayerConfiguration(
                  // placeholder:
                  expandToFill: true,
                  showPlaceholderUntilPlay: true,
                  placeholder: cachedNetworkImage(
                      imageUrl:
                          'https://media.istockphoto.com/photos/underwater-view-with-tuna-school-fish-in-ocean-sea-life-in-water-picture-id1189904571?b=1&k=20&m=1189904571&s=170667a&w=0&h=2vbdA5kQi0XTxWpggrDTqDzA63v2E-9u4BMT8OYOazw=',
                      height: 300.h,
                      width: 1.sw),
                  //startAt: Duration(seconds: 0),
                  controlsConfiguration:
                      const BetterPlayerControlsConfiguration(
                    enableSubtitles: false,
                    enableAudioTracks: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
