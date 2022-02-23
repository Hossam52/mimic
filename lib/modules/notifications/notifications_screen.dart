import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/play_video_icon.dart';
import 'package:mimic/widgets/rounded_image.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(title: 'Notifications'),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _NotificationWithDetails(),
              SizedBox(height: 10.h),
              Container(
                  color: ColorManager.seenNotificationBackground,
                  child: Column(
                    children: [
                      const _PersonNotification(
                        description: 'Shared an ETAs',
                      ),
                      Divider(color: ColorManager.grey),
                      const _PersonNotification(
                        description: 'Approved your challenge',
                      ),
                    ],
                  )),
              SizedBox(height: 8.h),
              _NotificationWithDetails(
                textColor: ColorManager.black,
                profileDescriptionColor: ColorManager.black,
                timeAgoColor: ColorManager.black,
                backgroundColor: ColorManager.seenNotificationBackground,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationPersonDetails extends StatelessWidget {
  const _NotificationPersonDetails(
      {Key? key, this.nameColor, this.descriptionColor, this.timeAgoColor})
      : super(key: key);
  final Color? nameColor;
  final Color? descriptionColor;
  final Color? timeAgoColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: RoundedImage(
              imagePath: 'assets/images/static/avatar.png',
              size: 50.r,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hossam Hassan',
                  style: getBoldStyle(
                    color: nameColor ?? ColorManager.white,
                  ),
                ),
                Text(
                  'Shared An ETA',
                  style: getRegularStyle(
                    fontSize: FontSize.s10,
                    color: descriptionColor ??
                        ColorManager.notificationPersonDetails,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '1M Ago',
            style: getRegularStyle(
                fontSize: FontSize.s10,
                color: timeAgoColor ?? ColorManager.white),
          )
        ],
      ),
    );
  }
}

class _NotificationWithDetails extends StatelessWidget {
  const _NotificationWithDetails(
      {Key? key,
      this.backgroundColor,
      this.timeAgoColor,
      this.textColor,
      this.profileDescriptionColor})
      : super(key: key);
  final Color? backgroundColor;
  final Color? timeAgoColor;
  final Color? textColor;
  final Color? profileDescriptionColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 18.0.h),
        child: Column(
          children: [
            _NotificationPersonDetails(
              nameColor: textColor,
              descriptionColor: profileDescriptionColor,
              timeAgoColor: timeAgoColor,
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 70.h,
                    child: SingleChildScrollView(
                      child: Text(
                        AppStrings.notificationDescription,
                        style: getRegularStyle(
                            color: textColor ?? ColorManager.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(18.w),
                    child: Column(
                      children: [
                        SizedBox(height: 8.h),
                        const _Video(),
                        SizedBox(height: 8.h),
                        _NotificationActions(
                          rejectBackgroundColor: backgroundColor,
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
    );
  }
}

class _PersonNotification extends StatelessWidget {
  const _PersonNotification({Key? key, required this.description})
      : super(key: key);
  final String description;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.all(8.w),
      leading: RoundedImage(
        imagePath: 'assets/images/static/avatar.png',
        size: 60.r,
      ),
      tileColor: ColorManager.seenNotificationBackground,
      title: Text('Duran Clyton', style: getRegularStyle()),
      isThreeLine: true,
      subtitle: Text(
        description,
        style: getRegularStyle(),
      ),
      trailing: Text('5M ago', style: getRegularStyle()),
    );
  }
}

class _Video extends StatelessWidget {
  const _Video({Key? key, this.defaultIconColor}) : super(key: key);
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

class _NotificationActions extends StatelessWidget {
  const _NotificationActions({Key? key, this.rejectBackgroundColor})
      : super(key: key);
  final Color? rejectBackgroundColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: DefaultButton(
          onPressed: () {
            Dialogs.acceptChallengeDialog(context);
          },
          text: 'Approve',
          hasBorder: false,
          radius: 8.r,
        )),
        const SizedBox(width: 10),
        Expanded(
            child: DefaultButton(
          onPressed: () {
            Dialogs.rejectChallengeDialog(context);
          },
          text: 'Reject',
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
