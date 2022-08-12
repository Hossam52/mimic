import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimic/models/notifications/notification.dart';
import 'package:mimic/modules/challenges/get_all_comments_cubit/get_all_comments_cubit.dart';
import 'package:mimic/modules/comments/comments_screen.dart';
import 'package:mimic/modules/notifications/notifications_cubit/notifications_cubit.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/shared/dialog_widgets/confirm_delete_notification_dialog.dart';
import 'package:mimic/shared/methods.dart';

import 'background_dismiss.dart';
import 'notification_person.dart';

class CommentOrReplyNotification extends StatelessWidget {
  const CommentOrReplyNotification(
      {Key? key,
      required this.notificationData,
      required this.indexNotification})
      : super(key: key);
  final NotificationData notificationData;
  final int indexNotification;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: const BackgroundDismiss(),
      onDismissed: (_) {
        NotificationsCubit.get(context).deleteNotification(
            notificationId: notificationData.id, index: indexNotification);
      },
      confirmDismiss: (_) async {
        return await showDialog(
            context: context,
            builder: (context) => const ConfirmDeleteNotificationDialog());
      },
      child: Container(
        color: ColorManager.seenNotificationBackground,
        child: InkWell(
          onTap: () async {
            return await showDialog(
              context: context,
              builder: (context) => BlocProvider(
                create: (context) => GetAllCommentsCubit()
                  ..getAllComments(notificationData.Video!.id),
                child: CommentsScreen(
                  videoId: notificationData.Video!.id,
                  commentsTotalNumber: 120,
                ),
              ),
            );

            // navigateTo(context, Routes)
          },
          child: Center(
            child: PersonNotification(
              notificationData: notificationData,
            ),
          ),
        ),
      ),
    );
  }
}
