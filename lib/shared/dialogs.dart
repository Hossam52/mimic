import 'package:flutter/material.dart';
import 'package:mimic/modules/comments/comments_screen.dart';
import 'package:mimic/modules/report/report_screen.dart';

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
}
