import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/comment_class.dart';
import 'package:mimic/modules/challenges/likes_cubit/likes_cubit.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/video_statistic_item.dart';

import 'comment_personal_details.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({Key? key, required this.comment}) : super(key: key);
  final Comment comment;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: AppSize.s10.h),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s15.r)),
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p8.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommentPersonDetails(
              comment: comment,
            ),
            SizedBox(height: AppSize.s15.h),
            _commentBody(comment.text),
            _commentActions(context)
          ],
        ),
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
            return LikesCubit.get(context).checkLikeProccessed(id: comment.id);
          },
          buildWhen: (previous, current) {
            return LikesCubit.get(context).checkLikeProccessed(id: comment.id);
          },
          listener: (context, state) {
            if (state is LikesLoading) {
              comment.liked = state.liked;
              // liked = state.liked;
              if (comment.liked) {
                comment.likesCount++;
              } else {
                comment.likesCount--;
              }
            } else if (state is LikesError) {
              if (comment.liked) {
                comment.likesCount++;
              } else {
                comment.likesCount--;
              }
            }
            // else
          },
          builder: (context, state) {
            return FavoriteIcon(
              count: comment.likesCount.toString(),
              filled: comment.liked,
              onPressed: () => LikesCubit.get(context)
                  .toggleLikeComment(comment.id, liked: comment.liked),
            );
          },
        ),
        // Icon(
        //   MimicIcons.favoriteOutline,
        //   color: ColorManager.favoriteColor,

        // ),
        Icon(
          MimicIcons.commentOutline,
          color: ColorManager.commentsColor,
        )
      ],
    );
  }
}
