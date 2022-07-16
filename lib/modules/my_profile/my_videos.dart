import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/video_models/reusable_video_list_controller.dart';
import 'package:mimic/models/video_models/videos_model.dart';
import 'package:mimic/modules/my_profile/profile_cubit/profile_cubit.dart';
import 'package:mimic/modules/video_play_test.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/widgets/default_text_button.dart';
import 'package:mimic/widgets/video_item.dart';

class MyVideos extends StatelessWidget {
  final Videos videos;
  MyVideos({Key? key, required this.videos}) : super(key: key);
  ReusableVideoListController videoListController =
      ReusableVideoListController();
  int selectedVideoPlayedIndex = -1;
  @override
  Widget build(BuildContext context) {
    // _betterPlayerPlaylistStateKey.currentState!.betterPlayerController!.pause();
    // List<BetterPlayerDataSource> dataSource = [
    //   BetterPlayerDataSource(
    //     BetterPlayerDataSourceType.network,
    //     videos.videos.first.videoUrl,
    //     placeholder: cachedNetworkImage(
    //         imageUrl:
    //             'https://media.istockphoto.com/photos/big-waver-raises-sand-of-ocean-and-has-white-foam-picture-id922736900?k=20&m=922736900&s=612x612&w=0&h=WR6coz13dJVkM1e2Fb-nkeCXNfN-WzDsWdZ0eb3ghHU=',
    //         height: 300.h,
    //         width: 1.sw),
    //   ),
    //   BetterPlayerDataSource(
    //     BetterPlayerDataSourceType.network,
    //     videos.videos.first.videoUrl,
    //     placeholder: cachedNetworkImage(
    //         imageUrl:
    //             'https://media.istockphoto.com/photos/big-waver-raises-sand-of-ocean-and-has-white-foam-picture-id922736900?k=20&m=922736900&s=612x612&w=0&h=WR6coz13dJVkM1e2Fb-nkeCXNfN-WzDsWdZ0eb3ghHU=',
    //         height: 300.h,
    //         width: 1.sw),
    //   ),
    // ];
    // return BetterPlayerPlaylist(
    //   betterPlayerDataSourceList: dataSource,
    //   betterPlayerConfiguration: BetterPlayerConfiguration(
    //     expandToFill: true,
    //     // showPlaceholderUntilPlay: _showPlaceholder,
    //     fullScreenAspectRatio: 0.5,
    //     deviceOrientationsOnFullScreen: [
    //       DeviceOrientation.portraitUp,
    //       DeviceOrientation.portraitDown
    //     ],
    //     //startAt: Duration(seconds: 0),

    //     overlay: SizedBox(
    //       height: 300.h,
    //       child: Align(
    //         alignment: Alignment.topLeft,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             //        PersonDetails(user: widget.video.user),
    //             SizedBox(
    //               height: 30.h,
    //             ),
    //             // _challengeActions(context),
    //           ],
    //         ),
    //       ),
    //     ),
    //     controlsConfiguration: const BetterPlayerControlsConfiguration(
    //       enableSubtitles: false,
    //       enableAudioTracks: false,
    //       enableSkips: false,
    //       loadingWidget: LoadingProgress(),
    //     ),
    //   ),
    //   betterPlayerPlaylistConfiguration:
    //       const BetterPlayerPlaylistConfiguration(initialStartIndex: 0,),
    // );
    return videos.videos.isEmpty
        ? Center(
            child: Text(
              AppStrings.noAvailableVideosUntillNow,
              style: getSemiBoldStyle(),
            ),
          )
        : Column(
            children: [
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (_, index) => SizedBox(height: 5.h),
                    shrinkWrap: true,
                    itemCount: videos.videos.length,
                    itemBuilder: (_, index) {
                      return VideoItemPlayer(
                        video: videos.videos[index],
                        controller: videos.videos,
                      );
                      // VideoOverview(
                      //   borderRadius: 13.r,
                      //   defaultIconColor: ColorManager.commentsColor,
                      // );
                    }),
              ),
              // SizedBox(
              //   height: AppSize.s10,
              // ),
              // if (videos.links.next != null)
              //   defaultTextButton(
              //       onPressed: () {
              //         ProfileCubit.get(context).getMoreMyVideos(page: 2);
              //       },
              //       text: AppStrings.more),
            ],
          );
  }
}
