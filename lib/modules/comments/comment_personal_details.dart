
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimic/models/comment_class.dart';
import 'package:mimic/modules/challenges/get_all_comments_cubit/get_all_comments_cubit.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';
import 'package:clipboard/clipboard.dart';

class CommentPersonDetails extends StatelessWidget {
  const CommentPersonDetails({Key? key, required this.comment})
      : super(key: key);
  final Comment comment;
  @override
  Widget build(BuildContext context) 
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
            onTap: () 
            {
              navigateTo(context, Routes.challengerProfile,
                  arguments: comment.user.id);
            },
            child: cachedNetworkImageProvider(comment.user.image, 20.r)),
        SizedBox(
          width: AppSize.s10.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                comment.user.name,
                style: getBoldStyle(),
              ),
              Text(
                comment.date,
                style: getRegularStyle(
                    color: ColorManager.lightGrey, fontSize: FontSize.s8),
              )
            ],
          ),
        ),
        const Spacer(),
        PopupMenuButton(
            icon: const Icon(Icons.more_horiz),
            //child: ,
            itemBuilder: ((context) => comment.userComment
                ? [
                    PopupMenuItem(
                      onTap: () async {
                        try {
                          await FlutterClipboard.copy(comment.text);
                          Fluttertoast.showToast(
                            msg: 'Comment copied successfully',
                            backgroundColor: ColorManager.primary,
                          );
                        } catch (e) {
                          rethrow;
                        }
                      },
                      child: Text(
                        AppStrings.copy.translateString(context),
                        style: getMediumStyle(),
                      ),
                    ),
                    PopupMenuItem(
                        onTap: () {
                          GetAllCommentsCubit.get(context)
                              .deleteComment(comment: comment);
                        },
                        child: Text(
                          AppStrings.delete.translateString(context),
                          style: getMediumStyle(),
                        )),
                  ]
                : [
                    PopupMenuItem(
                        child: Text(
                      AppStrings.report.translateString(context),
                      style: getMediumStyle(),
                    )),
                  ])),
      ],
    );
  }
}
