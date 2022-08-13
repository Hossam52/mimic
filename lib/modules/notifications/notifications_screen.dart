import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimic/enums/notifications_type.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/modules/notifications/notifications_cubit/notifications_cubit.dart';
import 'package:mimic/modules/notifications/widgets/admin_notification.dart';
import 'package:mimic/modules/notifications/widgets/comment_or_reply_notification.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/loading_brogress.dart';
import 'package:mimic/widgets/play_video_icon.dart';
import 'package:mimic/widgets/rounded_image.dart';

import 'widgets/notification_friend_tag.dart';
import 'widgets/notification_person.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({Key? key}) : super(key: key);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final BuildContext contextCubit =
        ModalRoute.of(context)!.settings.arguments as BuildContext;
    NotificationsCubit.get(contextCubit).init();
    NotificationsCubit.get(contextCubit).getAllNotifications();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        log('Enter End Screen');
        if (NotificationsCubit.get(contextCubit).checkFoundMore()) {
          NotificationsCubit.get(contextCubit).getAllNotifications();
        }
      }
    });
    return Scaffold(
      appBar: TransparentAppBar(
          title: AppStrings.notifications.translateString(context)),
      body: BlocProvider.value(
        value: NotificationsCubit.get(contextCubit),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
          child: Builder(builder: (context) {
            return BlocConsumer<NotificationsCubit, NotificationsState>(
              listener: (context, state) {
                if (state is NotificationsDeleteNotificationSuccess) {
                  Fluttertoast.showToast(
                    msg: AppStrings.notificationDeletedSuccessfully
                        .translateString(context),
                    backgroundColor: Colors.green,
                    textColor: ColorManager.white,
                  );
                } else if (state is NotificationsDeleteNotificationError) {
                  Fluttertoast.showToast(
                      msg: state.error,
                      backgroundColor: ColorManager.error,
                      textColor: ColorManager.white);
                } else if (state is NotificationsChangeStatusSuccess) {
                  Navigator.pop(context);
                  navigateTo(context, Routes.challengeDetails,
                      arguments: state.challengeId);
                }
              },
              builder: (context, state) {
                NotificationsCubit cubit = NotificationsCubit.get(context);
                if (state is NotificationsLoading && state.isFirst) {
                  return const LoadingProgressSearchChallanges();
                } else if (state is NotificationsError) {
                  return BuildErrorWidget(state.error);
                }
                return Column(
                  children: [
                    Expanded(
                        child: RefreshIndicator(
                      onRefresh: () async {
                        NotificationsCubit.get(contextCubit).init();
                        NotificationsCubit.get(contextCubit)
                            .getAllNotifications();
                      },
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: scrollController,
                        itemBuilder: (context, index) => NotificationsType
                                    .request.name ==
                                cubit.allNotifications[index].notificationType
                            ? NotificationWithDetails(
                                notification: cubit.allNotifications[index],
                                indexNotification: index,
                              )
                            : cubit.allNotifications[index].notificationType ==
                                    NotificationsType.comment.name
                                ? CommentOrReplyNotification(
                                    notificationData:
                                        cubit.allNotifications[index],
                                    indexNotification: index,
                                  )
                                : AdminNotification(
                                    notificationData:
                                        cubit.allNotifications[index],
                                    indexNotification: index,
                                  ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10.h,
                        ),
                        itemCount: cubit.allNotifications.length,
                      ),
                    )),
                    if (state is NotificationsLoading) const LoadingProgress(),
                  ],
                );
                // return SingleChildScrollView(
                //   child: Column(
                //     children: [
                //       NotificationWithDetails(),
                //       SizedBox(height: 10.h),
                //       Container(
                //           color: ColorManager.seenNotificationBackground,
                //           child: Column(
                //             children: [
                //               const PersonNotification(
                //                 description: 'Shared an ETAs',
                //               ),
                //               Divider(color: ColorManager.grey),
                //               const PersonNotification(
                //                 description: 'Approved your challenge',
                //               ),
                //             ],
                //           )),
                //       SizedBox(height: 8.h),
                //       NotificationWithDetails(
                //         textColor: ColorManager.black,
                //         profileDescriptionColor: ColorManager.black,
                //         timeAgoColor: ColorManager.black,
                //         backgroundColor:
                //             ColorManager.seenNotificationBackground,
                //       ),
                //     ],
                //   ),
                // );
              },
            );
          }),
        ),
      ),
    );
  }
}

class Video extends StatelessWidget {
  const Video({Key? key, this.defaultIconColor}) : super(key: key);
  final Color? defaultIconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.h,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
      ),
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/static/video_preview.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          const BlackOpacity(
            opacity: 0.37,
          ),
          PlayVideoIcon(size: 66.r),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.volume_mute,
                color: ColorManager.white,
                size: 30.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
