import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimic/modules/challenges/get_all_comments_cubit/get_all_comments_cubit.dart';
import 'package:mimic/modules/challenges/manage_replaies_cubit/manage_replaies_cubit.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/helpers/helper_methods.dart';

import 'add_comment_field.dart';
import 'mention_cubit/mention_cubit.dart';

class CommentFieldAndActions extends StatelessWidget {
  CommentFieldAndActions({
    Key? key,
    required this.controller,
    required this.formKey,
    required this.id,
    required this.focusNode,
    this.isComment = true,
    this.hint,
  }) : super(key: key);
  final TextEditingController controller;
  final GlobalKey<FlutterMentionsState> formKey;
  final FocusNode focusNode;
  final int id;
  bool isComment;
  String? hint;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.all(AppMargin.m8.r),
      child: BlocProvider(
        create: (context) => MentionCubit(),
        lazy: false,
        child: Builder(builder: (context) {
          return Row(
            children: [
              Expanded(
                child: BlocBuilder<MentionCubit, MentionState>(
                  builder: (mentionCubit, stateMention) {
                    return AddComment(
                      controller,
                      focusNode: focusNode,
                      mentionCubit: mentionCubit,
                      mentionKey: formKey,
                      hint: hint,
                    );
                  },
                ),
              ),
              SizedBox(width: AppSize.s20.w),
              GestureDetector(
                onTap: () {
                  if (controller.text.isNotEmpty) {
                    if (isComment) {
                      GetAllCommentsCubit.get(context).addComment(
                          videoId: id,
                          text: controller.text,
                          idsMention:
                              MentionCubit.get(context).mentionsIds.toList());
                    } else {
                      log('Reply On this Person');
                      ManageReplaiesCubit.get(context).addReply(
                        commentId: id,
                        text: controller.text,
                        idsMention:
                            MentionCubit.get(context).mentionsIds.toList(),
                      );
                    }
                    controller.clear();
                    formKey.currentState!.controller!.clear();
                    HelperMethods.closeKeyboard(context);
                  } else {
                    Fluttertoast.showToast(msg: 'Please enter comment firstly');
                  }
                },
                child: CircleAvatar(
                  backgroundColor:
                      hint != null ? ColorManager.primary : ColorManager.white,
                  child: Padding(
                    padding: EdgeInsets.all(AppPadding.p8.r),
                    child: FittedBox(
                      child: Icon(
                        Icons.send,
                        color: hint != null
                            ? ColorManager.white
                            : ColorManager.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
