import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/comment_class.dart';
import 'package:mimic/modules/challenges/get_all_comments_cubit/get_all_comments_cubit.dart';
import 'package:mimic/modules/challenges/likes_cubit/likes_cubit.dart';
import 'package:mimic/presentation/resourses/assets_manager.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/shared/helpers/helper_methods.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';
import 'package:mimic/widgets/dialog_card.dart';
import 'package:mimic/widgets/loading_brogress.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/rounded_image.dart';

import 'comment_item.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen(
      {Key? key, required this.videoId, required this.commentsTotalNumber})
      : super(key: key);
  final int videoId;
  int commentsTotalNumber;
  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    GetAllCommentsCubit _getAllCommentsCubit = GetAllCommentsCubit.get(context);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (_getAllCommentsCubit.commentsModel.comments!.links!.next != null) {
          _getAllCommentsCubit.getAllComments(videoId,
              page: ++_getAllCommentsCubit.page);
        }
        log('message');
      }
    });
    return BlocProvider(
      create: (context) => LikesCubit(),
      child: DialogCard(
        backgroundColor: ColorManager.commentsBackgroundColor,
        headerTitle: AppStrings.reactions,
        child: BlocConsumer<GetAllCommentsCubit, GetAllCommentsState>(
          listener: (context, state) {
            if (state is AddCommentSuccess) {
              commentsTotalNumber++;
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            } else if (state is DeleteCommentSuccess) {
              commentsTotalNumber--;
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            GetAllCommentsCubit getAllCommentsCubit =
                GetAllCommentsCubit.get(context);
            if (state is GetAllCommentsLoading && state.isFirst) {
              return const LoadingProgress();
            } else if (state is GetAllCommentsError) {
              return BuildErrorWidget(state.error);
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is AddCommentLoading ||
                      state is DeleteCommentLoading)
                    Column(
                      children: [
                        LinearProgressIndicator(
                          color: ColorManager.primary,
                        ),
                        SizedBox(
                          height: AppSize.s10.h,
                        )
                      ],
                    ),
                  _commentStatistics(commentsTotalNumber),
                  SizedBox(height: AppSize.s10.h),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: _comments(
                        getAllCommentsCubit.allComments,
                        controller: scrollController,
                      )),
                      if (state is GetAllCommentsLoading)
                        const LoadingProgress()
                    ],
                  )),
                  _CommentFieldAndActions(
                      controller: controller,
                      formKey: formKey,
                      videoId: videoId),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _commentStatistics(int numberOfComments) {
    return Row(
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
          child: Padding(
            padding: EdgeInsets.only(bottom: 7.0.h),
            child: Text(
              '$numberOfComments comment',
              style: getBoldStyle(fontSize: FontSize.s16),
            ),
          ),
        ),
        SizedBox(width: AppSize.s20.w),
        Row(
          children: [
            CircleAvatar(
              radius: AppSize.s10.r,
              backgroundColor: ColorManager.favoriteColor,
              child: FittedBox(
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.p4.r),
                  child: Icon(
                    MimicIcons.favoriteOutline,
                    color: ColorManager.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: AppSize.s8.w),
            Text(
              '75',
              style: getRegularStyle(),
            )
          ],
        )
      ],
    );
  }

  Widget _comments(List<Comment> comments,
      {required ScrollController controller}) {
    return comments.isEmpty
        ? Center(
            child: Text(
            'No available comments untill now',
            style: getBoldStyle(),
          ))
        : ListView.builder(
            controller: controller,
            itemCount: comments.length,
            itemBuilder: (_, index) {
              return CommentItem(comment: comments[index]);
            });
  }
}

class _CommentFieldAndActions extends StatelessWidget {
  const _CommentFieldAndActions(
      {Key? key,
      required this.controller,
      required this.formKey,
      required this.videoId})
      : super(key: key);
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final int videoId;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.all(AppMargin.m8.r),
      child: Form(
        key: formKey,
        child: Row(
          children: [
            Expanded(child: _commentField(controller: controller)),
            SizedBox(width: AppSize.s30.w),
            Icon(Icons.sentiment_satisfied_sharp,
                color: ColorManager.emotionColor),
            SizedBox(width: AppSize.s20.w),
            GestureDetector(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  GetAllCommentsCubit.get(context)
                      .addComment(videoId: videoId, text: controller.text);
                  controller.clear();
                  HelperMethods.closeKeyboard(context);
                }
              },
              child: CircleAvatar(
                backgroundColor: ColorManager.white,
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.p8.r),
                  child: FittedBox(
                    child: Icon(
                      Icons.send,
                      color: ColorManager.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _commentField({
    required TextEditingController controller,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppSize.s50.r)),
      borderSide: BorderSide.none,
    );
    return TextField(
      controller: controller,
      maxLines: 3,
      minLines: 1,
      decoration: InputDecoration(
        filled: true,
        border: border,
        focusedBorder: border,
        enabledBorder: border,
        disabledBorder: border,
        hintText: AppStrings.writeAcomment,
        contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p8.w),
        fillColor: ColorManager.white,
      ),
    );
  }
}
