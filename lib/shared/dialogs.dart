import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimic/modules/challenges/get_all_comments_cubit/get_all_comments_cubit.dart';
import 'package:mimic/modules/comments/comments_screen.dart';
import 'package:mimic/modules/my_challenges/complain_dialog.dart';
import 'package:mimic/modules/report/report_screen.dart';
import 'package:mimic/shared/dialog_widgets/notification_accept_reject_dialog.dart';
import 'package:mimic/shared/dialog_widgets/post_for_review.dart';
import 'package:mimic/shared/dialog_widgets/qr_dialog.dart';
import 'package:mimic/shared/helpers/helper_methods.dart';

class Dialogs {
  static Future<T?> showCommentsDialog<T>(BuildContext context, int videoId,
      {int? commentsTotalNumber}) async {
    bool dataFound = GetAllCommentsCubit.get(context).checkData(videoId);
    if (!dataFound) {
      GetAllCommentsCubit.get(context).getAllComments(videoId);
    }
    return await showDialog<T?>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: GetAllCommentsCubit.get(context),
        child: WillPopScope(
            onWillPop: () async {
              HelperMethods.closeKeyboard(context);
              return true;
            },
            child: CommentsScreen(
                videoId: videoId, commentsTotalNumber: commentsTotalNumber!)),
      ),
    );
  }

  static Future<T?> showReportDialog<T>(BuildContext context) {
    return showDialog<T?>(
      context: context,
      builder: (_) => const ReportScreen(),
    );
  }

  static Future<T?> showRejectedVideoReason<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const ComplainDialog(),
    );
  }

  static Future<T?> showQrSaveShare<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const QrDialogShareSave(),
    );
  }

  static Future<T?> acceptChallengeDialog<T>(
      BuildContext context, Function confirmOk) {
    return showDialog(
      context: context,
      builder: (_) => AcceptChallengeDialog(confirm: () 
      {
        confirmOk();
      }),
    );
  }

  static Future<T?> rejectChallengeDialog<T>(
      BuildContext context, Function confirmCancel) {
    return showDialog(
      context: context,
      builder: (_) => RejectChallengeDialog(confirmCancel: () {
        confirmCancel();
      }),
    );
  }

  static Future<T?> postForReviewDialog<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const PostForReviewDialog(),
    );
  }

  static Future<T?> shareSaveToGalleryDialog<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const ShareSaveToGalery(),
    );
  }
}
