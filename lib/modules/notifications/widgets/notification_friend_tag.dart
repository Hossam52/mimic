import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/notifications/notification.dart';
import 'package:mimic/modules/notifications/notifications_cubit/notifications_cubit.dart';
import 'package:mimic/modules/notifications/notifications_screen.dart';
import 'package:mimic/modules/notifications/widgets/background_dismiss.dart';
import 'package:mimic/modules/notifications/widgets/thumb_nail_video_action.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/dialog_widgets/confirm_delete_notification_dialog.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/shared/video_players_widgets/video_player_tag_notification.dart';
import 'package:mimic/widgets/defulat_button.dart';

import 'notification_personal_details.dart';

class NotificationWithDetails extends StatelessWidget {
  const NotificationWithDetails(
      {Key? key,
      this.backgroundColor,
      this.timeAgoColor,
      this.textColor,
      required this.notification,
      required this.indexNotification,
      this.profileDescriptionColor})
      : super(key: key);
  final NotificationData notification;
  final int indexNotification;
  final Color? backgroundColor;
  final Color? timeAgoColor;
  final Color? textColor;
  final Color? profileDescriptionColor;
  @override
  Widget build(BuildContext context) {
    int randomValue = Random.secure().nextInt(2);
    return Dismissible(
      key: UniqueKey(),
      background: const BackgroundDismiss(),
      onDismissed: (_) {
        NotificationsCubit.get(context).deleteNotification(
            notificationId: notification.id, index: indexNotification);
      },
      confirmDismiss: (_) async {
        return await showDialog(
            context: context,
            builder: (context) => const ConfirmDeleteNotificationDialog());
      },
      child: Container(
        decoration: BoxDecoration(
          color: randomValue == 0
              ? ColorManager.primary
              : ColorManager.primaryOpacity60,
          // backgroundColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 18.0.h),
          child: Column(
            children: [
              NotificationPersonDetails(
                notificationData: notification,
                nameColor: textColor,
                descriptionColor: profileDescriptionColor,
                timeAgoColor: timeAgoColor,
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 0),
                child: Column(
                  children: [
                    Text(
                      notification.body,
                      style: getRegularStyle(
                          color: textColor ?? ColorManager.white),
                    ),
                    Padding(
                      padding: EdgeInsets.all(18.w),
                      child: Column(
                        children: [
                          ThumbNailVideoAction(
                            video: notification.Video!,
                          ),
                          SizedBox(height: 8.h),
                          Visibility(
                            visible: notification.notificationSatus == null,
                            child: _NotificationActions(
                              notificationData: notification,
                              rejectBackgroundColor: backgroundColor,
                              index: indexNotification,
                            ),
                          ),
                          Visibility(
                            visible: notification.notificationSatus != null,
                            child: DefaultButton(
                              width: 200.w,
                              onPressed: () {
                                navigateTo(context, Routes.challengeDetails,
                                    arguments:
                                        notification.challengeId.toString());
                              },
                              text: AppStrings.viewChallenge
                                  .translateString(context),
                              hasBorder: false,
                              radius: 8.r,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationActions extends StatelessWidget {
  const _NotificationActions({
    Key? key,
    this.rejectBackgroundColor,
    required this.index,
    required this.notificationData,
  }) : super(key: key);
  final Color? rejectBackgroundColor;
  final int index;
  final NotificationData notificationData;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: DefaultButton(
          onPressed: () {
            Dialogs.acceptChallengeDialog(
              context,confirmOk: 
              ()async {
              //  Navigator.pop(context);
                NotificationsCubit.get(context).changeNotificationState(
                  notificationId: notificationData.id,
                  notificationIndex: index,
                );
               
              },
            );
          },
          text: AppStrings.approve.translateString(context),
          hasBorder: false,
          radius: 8.r,
        )),
        SizedBox(width: 10.w),
        Expanded(
            child: DefaultButton(
          onPressed: () {
            Dialogs.rejectChallengeDialog(context, () {
              NotificationsCubit.get(context).deleteNotification(
                  notificationId: notificationData.id, index: index);
            });
          },
          text: AppStrings.reject.translateString(context),
          radius: 8.r,
          borderColor: ColorManager.white,
          backgroundColor:
              rejectBackgroundColor ?? Theme.of(context).primaryColor,
          foregroundColor: ColorManager.white,
        )),
      ],
    );
  }
}
