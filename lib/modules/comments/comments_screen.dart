import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/comment_class.dart';
import 'package:mimic/modules/challenges/get_all_comments_cubit/get_all_comments_cubit.dart';
import 'package:mimic/modules/challenges/likes_cubit/likes_cubit.dart';
import 'package:mimic/modules/challenges/manage_replaies_cubit/manage_replaies_cubit.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/shared/helpers/helper_methods.dart';
import 'package:mimic/widgets/dialog_card.dart';
import 'package:mimic/widgets/loading_brogress.dart';
import 'package:mimic/widgets/mimic_icons.dart';

import 'comment_item.dart';
import 'input_field_comment.dart';

class CommentsScreen extends StatefulWidget {
  CommentsScreen(
      {Key? key, required this.videoId, required this.commentsTotalNumber})
      : super(key: key);
  final int videoId;
  int commentsTotalNumber;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController controller = TextEditingController();

  final formKey = GlobalKey<FlutterMentionsState>();

  FocusNode focusNode = FocusNode();

  final ScrollController scrollController = ScrollController();
  KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();
  late StreamSubscription<bool> keyboardSubscription;
  @override
  void initState() {
    // Subscribe

    super.initState();
  }

  @override
  void dispose() {
    // keyboardSubscription.cancel().then((value) {
    super.dispose();
    // });
  }

  late ManageReplaiesCubit _manageReplaiesCubit;

  @override
  Widget build(BuildContext context) {
    // keyboardSubscription =
    //     KeyboardVisibilityController().onChange.listen((bool visible) {
    //   if (!visible) {
    //     //  if (FocusScope.of(context).hasPrimaryFocus) {
    //     FocusScope.of(context).unfocus();
    //     // HelperMethods.closeKeyboard(context);

    //     ///  }
    //     _manageReplaiesCubit.clear();
    //   }
    // });
    GetAllCommentsCubit _getAllCommentsCubit = GetAllCommentsCubit.get(context);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (_getAllCommentsCubit.commentsModel.comments!.links!.next != null) {
          _getAllCommentsCubit.getAllComments(widget.videoId,
              page: ++_getAllCommentsCubit.page);
        }
        log('message');
      }
    });
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LikesCubit(),
        ),
        // BlocProvider(
        //   create: (context) => ManageReplaiesCubit(),
        //   lazy: false,
        // ),
      ],
      child: Builder(builder: (context) {
        // _manageReplaiesCubit = ManageReplaiesCubit.get(context);
        return GestureDetector(
          onTap: () => HelperMethods.closeKeyboard(context),
          child: DialogCard(
            backgroundColor: ColorManager.commentsBackgroundColor,
            headerTitle: AppStrings.reactions,
            child: BlocConsumer<GetAllCommentsCubit, GetAllCommentsState>(
              listener: (context, state) {
                if (state is AddCommentSuccess) {
                  widget.commentsTotalNumber++;
                  if (_getAllCommentsCubit.allComments.length > 1) {
                    scrollController
                        .jumpTo(scrollController.position.maxScrollExtent);
                  }
                } else if (state is DeleteCommentSuccess) {
                  widget.commentsTotalNumber--;
                }
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
                      _commentStatistics(widget.commentsTotalNumber),
                      SizedBox(height: AppSize.s10.h),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: _comments(
                            getAllCommentsCubit.allComments,
                            controller: scrollController,
                            textController: controller,
                            formKey: formKey,
                          )),
                          if (state is GetAllCommentsLoading)
                            const LoadingProgress()
                        ],
                      )),
                      CommentFieldAndActions(
                        controller: controller,
                        formKey: formKey,
                        focusNode: focusNode,
                        id: widget.videoId,
                        isComment: true,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        );
      }),
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
        // Row(
        //   children: [
        //     CircleAvatar(
        //       radius: AppSize.s10.r,
        //       backgroundColor: ColorManager.favoriteColor,
        //       child: FittedBox(
        //         child: Padding(
        //           padding: EdgeInsets.all(AppPadding.p4.r),
        //           child: Icon(
        //             MimicIcons.favoriteOutline,
        //             color: ColorManager.white,
        //           ),
        //         ),
        //       ),
        //     ),
        //     SizedBox(width: AppSize.s8.w),
        //     Text(
        //       '75',
        //       style: getRegularStyle(),
        //     )
        //   ],
        // )
      ],
    );
  }

  Widget _comments(
    List<Comment> comments, {
    required ScrollController controller,
    required TextEditingController textController,
    required GlobalKey<FlutterMentionsState> formKey,
  }) {
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
              return BlocProvider(
                create: (context) => ManageReplaiesCubit(),
                child: CommentItem(
                  focusNode: focusNode,
                  comment: comments[index],
                  commentIndex: index,
                  replyController: textController,
                  formKey: formKey,
                ),
              );
            });
  }
}

Widget _commentField({
  required TextEditingController controller,
  required Function(String value) validator,
  required FocusNode focusNode,
}) {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppSize.s50.r)),
    borderSide: BorderSide.none,
  );
  return TextFormField(
    focusNode: focusNode,
    validator: (value) {
      return validator(value!);
    },
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
