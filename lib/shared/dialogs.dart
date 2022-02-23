import 'package:flutter/material.dart';
import 'package:mimic/modules/comments/comments_screen.dart';
import 'package:mimic/modules/my_challenges/complain_dialog.dart';
import 'package:mimic/modules/report/report_screen.dart';
import 'package:mimic/shared/dialog_widgets/notification_accept_reject_dialog.dart';
import 'package:mimic/shared/dialog_widgets/post_for_review.dart';
import 'package:mimic/shared/dialog_widgets/qr_dialog.dart';

class Dialogs {
  static Future<T?> showCommentsDialog<T>(BuildContext context) {
    return showDialog<T?>(
      context: context,
      builder: (context) => const CommentsScreen(),
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

  static Future<T?> acceptChallengeDialog<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const AcceptChallengeDialog(),
    );
  }

  static Future<T?> rejectChallengeDialog<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const RejectChallengeDialog(),
    );
  }

  static Future<T?> postForReviewDialog<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const PostForReviewDialog(),
    );
  }

  static Future<T?> shareSaveToGalleryDialog<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const ShareSaveToGalery(),
    );
  }
}
