import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/comment_class.dart';
import 'package:mimic/modules/challenges/likes_cubit/likes_cubit.dart';
import 'package:mimic/modules/comments/body_widget.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/widgets/video_statistic_item.dart';

import 'replay_personal_details.dart';

class ReplayItem extends StatelessWidget {
  const ReplayItem({Key? key, required this.replay}) : super(key: key);
  final Replay replay;
  @override
  Widget build(BuildContext context) {
    log(replay.id.toString());
    return Container(
      padding: EdgeInsets.only(
          left: AppPadding.p8.r,
          right: AppPadding.p8.r,
          top: AppPadding.p8.r,
          bottom: AppPadding.p4.r),
      margin: EdgeInsetsDirectional.only(
          top: AppSize.s10.h, bottom: AppSize.s3.h, start: 10.w),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(AppSize.s15.r),
        border: BorderDirectional(
          start: BorderSide(
            color: ColorManager.black.withOpacity(0.3),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReplayPersonDetails(
            replay: replay,
          ),
          SizedBox(height: AppSize.s5.h),
          BodyWidget(body: replay.text),
          _commentActions(
            context,
          )
        ],
      ),
    );
  }

  Widget _commentBody(String body) {
    return Text(
      body,
      style: getRegularStyle(),
    );
  }

  Widget _commentActions(BuildContext context) {
    return Wrap(
      spacing: AppSize.s20.w,
      children: [
        BlocConsumer<LikesCubit, LikesState>(
          listenWhen: (previous, current) {
            return LikesCubit.get(context).checkLikeProccessed(id: replay.id);
          },
          buildWhen: (previous, current) {
            return LikesCubit.get(context).checkLikeProccessed(id: replay.id);
          },
          listener: (context, state) {
            if (state is LikesLoading) {
              replay.liked = state.liked;
              // liked = state.liked;
              if (replay.liked) {
                replay.likesCount++;
              } else {
                replay.likesCount--;
              }
            } else if (state is LikesError) {
              if (replay.liked) {
                replay.likesCount++;
              } else {
                replay.likesCount--;
              }
            }
            // else
          },
          builder: (context, state) {
            return FavoriteIcon(
              count: replay.likesCount.toString(),
              filled: replay.liked,
              onPressed: () => LikesCubit.get(context)
                  .toggleLikeReplay(replay.id, liked: replay.liked),
            );
          },
        ),
        // Icon(
        //   MimicIcons.favoriteOutline,
        //   color: ColorManager.favoriteColor,

        // ),
        // Icon(
        //   MimicIcons.commentOutline,
        //   color: ColorManager.commentsColor,
        // )
      ],
    );
  }
}
