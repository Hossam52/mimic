import 'package:flutter/material.dart';
import 'package:mimic/models/notifications/notification.dart';
import 'package:mimic/modules/notifications/notifications_cubit/notifications_cubit.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/shared/dialog_widgets/confirm_delete_notification_dialog.dart';

import 'background_dismiss.dart';
import 'notification_person.dart';

class AdminNotification extends StatelessWidget {
  AdminNotification({Key? key, required this.notificationData,required this.indexNotification})
      : super(key: key);
  final NotificationData notificationData;
  final int indexNotification;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: const BackgroundDismiss(),
      onDismissed: (_) {
        NotificationsCubit.get(context).deleteNotification(notificationId:  notificationData.id,
        index: indexNotification);
      },
      confirmDismiss: (_) async {
        return await showDialog(
            context: context,
            builder: (context) => const ConfirmDeleteNotificationDialog());
      },
      child: Container(
          color: ColorManager.seenNotificationBackground,
          child: Column(
            children: [
              PersonNotification(
                notificationData: notificationData,
              ),
              // Divider(color: ColorManager.grey),
              // PersonNotification(
              //   notificationData: notificationData,
              // ),
            ],
          )),
    );
  }
}
