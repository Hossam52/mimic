import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/main.dart';
import 'package:mimic/models/video_models/video.dart';
import 'package:mimic/modules/challenges/challange_data_cubit/challange_data_cubit.dart';
import 'package:mimic/modules/challenges/get_all_comments_cubit/get_all_comments_cubit.dart';
import 'package:mimic/modules/challenges/likes_cubit/likes_cubit.dart';
import 'package:mimic/modules/challenges/watch_video_challanger_cubit/watch_video_challanger_cubit.dart';
import 'package:mimic/modules/challenges/widgets/challenge_person_details.dart';
import 'package:mimic/modules/video_player_challanger.dart';
import 'package:mimic/modules/video_player_only.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/widgets/person_details.dart';
import 'package:mimic/widgets/video_statistic_item.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/play_video_icon.dart';

class ChallengesGridView extends StatelessWidget {
  const ChallengesGridView(
      {Key? key,
      this.crossAxisCount = 2,
      required this.context,
      this.showPlayIcon = true})
      : super(key: key);
  final bool showPlayIcon;
  final int crossAxisCount;
  final BuildContext context;
  //final ChallangeDataCubit challangeDataCubit;
  @override
  Widget build(BuildContext context) {
    List<Video> videos = ChallangeDataCubit.get(context).videosChallengers;
    log(videos.length.toString());
    return GridView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: videos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.w,
          crossAxisSpacing: 20.h,
          mainAxisExtent: 290.h,
        ),
        itemBuilder: (_, index) {
          return _ChallengeItemPreview(
            showPlayIcon: showPlayIcon,
            video: videos[index],
          );
        });
  }
}

class _ChallengeItemPreview extends StatelessWidget {
  _ChallengeItemPreview({Key? key, this.showPlayIcon = true, this.video})
      : super(key: key);
  final bool showPlayIcon;
  Video? video;
  @override
  Widget build(BuildContext context) {
    log(video!.id);
    return Builder(builder: (context) {
      return GestureDetector(
          onTap: () {
            log('First');
            showDialog(
                context: context,
                builder: (_) {
                  WatchVideoChallangerCubit.get(context)
                      .watchVideoView(int.parse(video!.id));
                  return VideoPopUp(
                    video: video,
                    contextCubit: context,
                  );
                });
          },
          child: Card(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        cachedNetworkImage(
                          imageUrl: video!.thumNailUrl,
                          height: double.maxFinite,
                          width: double.maxFinite,
                        ),

                        // PersonDetails(),
                        if (showPlayIcon) const BlackOpacity(opacity: 0.4),
                        if (showPlayIcon) const Center(child: PlayVideoIcon()),
                      ],
                    ),
                  ),
                  _videoStatistics(
                    context,
                    video: video!,
                    videoId: int.parse(video!.id),
                  ),
                ],
              )));
    });
  }

  Widget _videoStatistics(context,
      {required Video video, required int videoId}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h),
      child: Wrap(
        spacing: 10.w,
        children: [
          BlocConsumer<LikesCubit, LikesState>(
            listenWhen: (previous, current) {
              return LikesCubit.get(context)
                  .checkLikeProccessed(id: int.parse(video.id));
            },
            buildWhen: (previous, current) {
              return LikesCubit.get(context)
                  .checkLikeProccessed(id: int.parse(video.id));
            },
            listener: (context, state) {
              if (state is LikesLoading) {
                video.authLike = state.liked;
                // liked = state.liked;
                if (video.authLike) {
                  video.likeNumber++;
                } else {
                  video.likeNumber--;
                }
              } else if (state is LikesError) {
                video.authLike = state.liked;
                if (video.authLike) {
                  video.likeNumber++;
                } else {
                  video.likeNumber--;
                }
              }
              // else
            },
            builder: (context, state) {
              return FavoriteIcon(
                count: '${video.likeNumber}',
                filled: video.authLike,
                textColor: ColorManager.black,
                onPressed: () {
                  LikesCubit.get(context).toggleLikeVideo(
                    videoId,
                    liked: video.authLike,
                  );
                },
              );
            },
          ),
          BlocConsumer<GetAllCommentsCubit, GetAllCommentsState>(
            listener: (context, state) {
              if (state is AddCommentSuccess) {
                video.commentNumber++;
              } else if (state is DeleteCommentSuccess) {
                video.commentNumber--;
              }
            },
            listenWhen: (pre, current) =>
                GetAllCommentsCubit.get(context).checkRebuild(videoId),
            buildWhen: (previous, current) =>
                GetAllCommentsCubit.get(context).checkRebuild(videoId),
            builder: (context, state) {
              return CommentIcon(
                count: video.commentNumber.toString(),
                textColor: ColorManager.black,
                onPressed: () {
                  // bool dataFound =
                  //     GetAllCommentsCubit.get(context).checkData(videoId);
                  // if (!dataFound) {
                  //   GetAllCommentsCubit.get(context).getAllComments(videoId);
                  // }
                  Dialogs.showCommentsDialog(
                    context,
                    videoId,
                    commentsTotalNumber: video.commentNumber,
                  );
                },
              );
            },
          ),
          BlocConsumer<WatchVideoChallangerCubit, WatchVideoChallangerState>(
            listener: ((context, state) {
              video.numberOfwatches++;
            }),
            listenWhen: (previous, current) =>
                current is WatchVideoChallangerSuccess &&
                WatchVideoChallangerCubit.get(context)
                    .checkVideoViewd(int.parse(video.id)),
            buildWhen: (previous, current) =>
                current is WatchVideoChallangerSuccess &&
                WatchVideoChallangerCubit.get(context)
                    .checkVideoViewd(int.parse(video.id)),
            builder: (context, state) {
              return ViewIcon(
                count: video.numberOfwatches.toString(),
                iconColor: ColorManager.commentsColor,
                textColor: ColorManager.black,
              );
            },
          )
        ],
      ),
    );
  }
}

class VideoPopUp extends StatelessWidget {
  VideoPopUp({Key? key, this.video, this.contextCubit}) : super(key: key);
  Video? video;
  BuildContext? contextCubit;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16.w),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(21.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          video != null
              ? VideoPlayerChallanger(video: video!)
              : _video(context),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.0.h, horizontal: 10.w),
            child: _statistics(
              contextCubit!,
              video: video!,
              videoId: int.parse(video!.id),
            ),
          ),
        ],
      ),
    );
  }

  Widget _video(context) {
    return SizedBox(
      height: 250.h,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Image.asset(getVideoImageRandom(),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill),
          Center(
              child: PlayVideoIcon(
            size: 50.r,
          )),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.volume_off_outlined,
                  color: ColorManager.white,
                  size: 25.r,
                ),
              )),
        ],
      ),
    );
  }

  Widget _statistics(
    BuildContext context, {
    required Video video,
    required int videoId,
  }) {
    return Wrap(
      spacing: 10.w,
      children: [
        // Builder(builder: (context) {
        BlocProvider.value(
          value: LikesCubit.get(context),
          child: BlocBuilder<LikesCubit, LikesState>(
            builder: (context, state) {
              return FavoriteIcon(
                  count: '${video.likeNumber}',
                  filled: video.authLike,
                  textColor: ColorManager.black,
                  onPressed: () {
                    LikesCubit.get(context)
                        .toggleLikeVideo(videoId, liked: video.authLike);
                  });
            },
          ),
        ),
        // }),
        BlocProvider.value(
          value: GetAllCommentsCubit.get(context),
          child: CommentIcon(
            count: video.commentNumber.toString(),
            textColor: ColorManager.black,
            onPressed: () {
              Dialogs.showCommentsDialog(context, videoId,
                  commentsTotalNumber: video.commentNumber);
            },
          ),
        ),
        BlocProvider.value(
          value: WatchVideoChallangerCubit.get(context),
          child:
              BlocBuilder<WatchVideoChallangerCubit, WatchVideoChallangerState>(
            builder: (context, state) {
              return ViewIcon(
                count: '${video.numberOfwatches}',
                textColor: ColorManager.black,
                iconColor: ColorManager.commentsColor,
              );
            },
          ),
        ),
      ],
    );
  }
}
