import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/comment_class.dart';
import 'package:mimic/modules/challenges/get_all_comments_cubit/get_all_comments_cubit.dart';
import 'package:mimic/modules/challenges/likes_cubit/likes_cubit.dart';
import 'package:mimic/modules/challenges/manage_replaies_cubit/manage_replaies_cubit.dart';
import 'package:mimic/modules/comments/body_widget.dart';
import 'package:mimic/modules/comments/replay_item.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/widgets/loading_brogress.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/video_statistic_item.dart';

import 'comment_personal_details.dart';
import 'input_field_comment.dart';
import 'row_expand_widget.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    Key? key,
    required this.comment,
    required this.commentIndex,
    required this.formKey,
    required this.replyController,
    required this.focusNode,
  }) : super(key: key);
  final Comment comment;
  final FocusNode focusNode;
  final int commentIndex;
  final GlobalKey<FlutterMentionsState> formKey;
  final TextEditingController replyController;
  @override
  Widget build(BuildContext context) {
    log(comment.id.toString());
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
            BodyWidget(body: comment.text),
            CommentActions(
              //  context,
              onPressed: () {
                // focusNode.requestFocus();

                // log('data ');
                // focusNode.requestFocus();
                // replyController. = comment.user.name;
              },
              comment: comment,
              commentIndex: commentIndex,
            ),
          ],
        ),
      ),
    );
  }

  // Widget _commentBody(String body) {
  //   return LinkifyText(
  //     body,
  //     linkTypes: const [LinkType.userTag],
  //     textStyle: getRegularStyle(),
  //     linkStyle: getRegularStyle(color: Colors.blue),
  //     onTap: (client) {
  //       navigateTo(context, Routes.challengerProfile, arguments: client.value);
  //     },
  //   );

  //   Text(
  //     body,
  //     style: getRegularStyle(),
  //   );
  // }

  Widget _commentActions(BuildContext context) {
    return BlocConsumer<ManageReplaiesCubit, ManageReplaiesState>(
      listener: (context, manageReplaiesState) {
        if (manageReplaiesState is GetAllReplaiesSuccess) {
          GetAllCommentsCubit.get(context).allComments[commentIndex].replies =
              ManageReplaiesCubit.get(context).allReplies;
        }
      },
      listenWhen: (_, current) =>
          ManageReplaiesCubit.get(context).checkRebuild(comment.id),
      buildWhen: (_, current) =>
          ManageReplaiesCubit.get(context).checkRebuild(comment.id),
      builder: (context, manageReplaiesState) {
        return Wrap(
          spacing: AppSize.s20.w,
          children: [
            BlocConsumer<LikesCubit, LikesState>(
              listenWhen: (previous, current) {
                return LikesCubit.get(context)
                    .checkLikeProccessed(id: comment.id);
              },
              buildWhen: (previous, current) {
                return LikesCubit.get(context)
                    .checkLikeProccessed(id: comment.id);
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
            ),
            if (comment.replay != null) ReplayItem(replay: comment.replay!),
            if (manageReplaiesState is GetAllReplaiesSuccess)
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) =>
                    ReplayItem(replay: comment.replies[index])),
                separatorBuilder: (context, index) => SizedBox(
                  height: AppSize.s5.h,
                ),
                itemCount: comment.replies.length,
              ),
            InkWell(
              onTap: () {
                ManageReplaiesCubit.get(context).getAllReplaies(
                  comment.id,
                );
              },
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 10.w),
                child: Row(
                  children: [
                    Text(
                      'show more',
                      style: getMediumStyle(),
                    ),
                    const Spacer(),
                    const Icon(Icons.expand_more_sharp)
                  ],
                ),
              ),
            ),
            if (manageReplaiesState is GetAllReplaiesLoading)
              const LoadingProgress(),
          ],
        );
      },
    );
  }
}

class CommentActions extends StatefulWidget {
  CommentActions({
    Key? key,
    required this.comment,
    required this.commentIndex,
    required this.onPressed,
  }) : super(key: key);
  int commentIndex;
  Comment comment;
  Function onPressed;
  @override
  State<CommentActions> createState() => _CommentActionsState();
}

class _CommentActionsState extends State<CommentActions> {
  ScrollController controller = ScrollController();
  GlobalKey<FlutterMentionsState> formKey = GlobalKey<FlutterMentionsState>();
  final TextEditingController replyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final String hint = 'Reply on ' + widget.comment.user.name;

    return BlocProvider(
      create: (context) => ManageReplaiesCubit(),
      child: BlocConsumer<ManageReplaiesCubit, ManageReplaiesState>(
        listener: (context, manageReplaiesState) {
          if (manageReplaiesState is GetAllReplaiesSuccess) {
            log('Enter change replies');
            widget.comment.replies =
                ManageReplaiesCubit.get(context).allReplies;
          } else if (manageReplaiesState is AddReplySuccess) {
            if (GetAllCommentsCubit.get(context)
                    .allComments[widget.commentIndex]
                    .numOfReplies ==
                0) {
              GetAllCommentsCubit.get(context)
                  .allComments[widget.commentIndex]
                  .replay = manageReplaiesState.replay;
              //increment number of replies,
              GetAllCommentsCubit.get(context)
                  .allComments[widget.commentIndex]
                  .numOfReplies = 1;
              ManageReplaiesCubit.get(context).firstMore = true;
            } else {
              GetAllCommentsCubit.get(context)
                  .allComments[widget.commentIndex]
                  .numOfReplies++;
              GetAllCommentsCubit.get(context)
                  .allComments[widget.commentIndex]
                  .replies
                  .add(manageReplaiesState.replay);
            }
          } else if (manageReplaiesState is DeleteReplySuccess) {
            if (GetAllCommentsCubit.get(context)
                    .allComments[widget.commentIndex]
                    .numOfReplies ==
                1) {
              GetAllCommentsCubit.get(context)
                  .allComments[widget.commentIndex]
                  .replay = null;
            }
            GetAllCommentsCubit.get(context)
                .allComments[widget.commentIndex]
                .numOfReplies--;
            widget.comment.replies.removeWhere(
                (element) => element.id == manageReplaiesState.replay.id);
            //        .remove(manageReplaiesState.replay);
            if (GetAllCommentsCubit.get(context)
                    .allComments[widget.commentIndex]
                    .numOfReplies ==
                1) {
              ManageReplaiesCubit.get(context).firstMore = false;
            }
          }
          {}
        },
        // listenWhen: (_, current) {
        //   bool isRebuild =
        //       ManageReplaiesCubit.get(context).checkRebuild(widget.comment.id);
        //   log(isRebuild.toString());
        //   return isRebuild;
        // },
        // buildWhen: (_, current) =>
        //     ManageReplaiesCubit.get(context).checkRebuild(widget.comment.id),
        builder: (context, manageReplaiesState) {
          log('Rebuild Replies');
          return Wrap(
            spacing: AppSize.s20.w,
            children: [
              BlocConsumer<LikesCubit, LikesState>(
                listenWhen: (previous, current) {
                  return LikesCubit.get(context)
                      .checkLikeProccessed(id: widget.comment.id);
                },
                buildWhen: (previous, current) {
                  return LikesCubit.get(context)
                      .checkLikeProccessed(id: widget.comment.id);
                },
                listener: (context, state) {
                  if (state is LikesLoading) {
                    widget.comment.liked = state.liked;
                    // liked = state.liked;
                    if (widget.comment.liked) {
                      widget.comment.likesCount++;
                    } else {
                      widget.comment.likesCount--;
                    }
                  } else if (state is LikesError) {
                    if (widget.comment.liked) {
                      widget.comment.likesCount++;
                    } else {
                      widget.comment.likesCount--;
                    }
                  }
                  // else
                },
                builder: (context, state) {
                  return FavoriteIcon(
                    count: widget.comment.likesCount.toString(),
                    filled: widget.comment.liked,
                    onPressed: () => LikesCubit.get(context).toggleLikeComment(
                        widget.comment.id,
                        liked: widget.comment.liked),
                  );
                },
              ),

              InkWell(
                onTap: () {
                  ManageReplaiesCubit.get(context).openReplyField();
                  widget.onPressed();
                },
                child: Icon(
                  MimicIcons.commentOutline,
                  color: ColorManager.commentsColor,
                ),
              ),
              if (widget.comment.replay != null)
                ReplayItem(replay: widget.comment.replay!),
              // if (manageReplaiesState is DeleteReplyLoading)
              //   const LinearProgressIndicator(),
              if ((manageReplaiesState is GetAllReplaiesLoading &&
                      !manageReplaiesState.isFirst) ||
                  manageReplaiesState is GetAllReplaiesSuccess ||
                  manageReplaiesState is DeleteReplyLoading ||
                  manageReplaiesState is DeleteReplySuccess ||
                  manageReplaiesState is RebuildUI ||
                  manageReplaiesState is AddReplyLoading ||
                  manageReplaiesState is AddReplySuccess ||
                  manageReplaiesState is AddReplyError ||
                  ManageReplaiesCubit.get(context).expandMore)
                if (ManageReplaiesCubit.get(context).expandMore)
                  ListView.separated(
                    shrinkWrap: true,
                    controller: controller,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) =>
                        ReplayItem(replay: widget.comment.replies[index])),
                    separatorBuilder: (context, index) => SizedBox(
                      height: AppSize.s5.h,
                    ),
                    itemCount: widget.comment.replies.length,
                  ),
              if (ManageReplaiesCubit.get(context).replyFieldOpened)
                CommentFieldAndActions(
                  controller: replyController,
                  focusNode: FocusNode(),
                  formKey: formKey,
                  isComment: false,
                  id: widget.comment.id,
                  hint: hint,
                ),
              if ((widget.comment.numOfReplies > 1 &&
                      (ManageReplaiesCubit.get(context).allReplies.isEmpty)) ||
                  (ManageReplaiesCubit.get(context).allReplies.isNotEmpty &&
                      (ManageReplaiesCubit.get(context)
                              .replaiesModel
                              .links!
                              .next !=
                          null)))
                InkWell(
                  onTap: () {
                    ManageReplaiesCubit.get(context).getAllReplaies(
                      widget.comment.id,
                    );
                  },
                  child: const RowExpandWidget(
                    title: 'Show more',
                    iconData: Icons.expand_more_sharp,
                  ),
                ),

              if (widget.comment.numOfReplies > 1 &&
                  ManageReplaiesCubit.get(context).allReplies.isNotEmpty &&
                  ManageReplaiesCubit.get(context).replaiesModel.links!.next ==
                      null)
                InkWell(
                  onTap: () {
                    ManageReplaiesCubit.get(context).expandMoreToggle();
                  },
                  child: !ManageReplaiesCubit.get(context).expandMore ||
                          ManageReplaiesCubit.get(context).firstMore
                      ? const RowExpandWidget(
                          title: 'Show more',
                          iconData: Icons.expand_more_sharp,
                        )
                      : const RowExpandWidget(
                          title: 'Show less',
                          iconData: Icons.expand_less_sharp,
                        ),
                ),
              if (manageReplaiesState is GetAllReplaiesLoading)
                const LoadingProgress(),
            ],
          );
        },
      ),
    );
  }
}
