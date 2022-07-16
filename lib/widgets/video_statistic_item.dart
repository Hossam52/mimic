import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class VideStatisticsItem extends StatelessWidget {
  const VideStatisticsItem(this.icon, this.count,
      {Key? key,
      this.filledColor,
      this.iconSize,
      this.onPressed,
      this.textColor})
      : super(key: key);
  final IconData icon;
  final Color? filledColor;
  final String count;
  final double? iconSize;
  final VoidCallback? onPressed;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4.w),
      child: Padding(
        padding: EdgeInsets.all(4.r),
        child: GestureDetector(
          onTap: onPressed,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: AppSize.smallIconSize,
                color: filledColor ?? ColorManager.commentsColor,
              ),
              Text(
                count,
                style: getSemiBoldStyle(
                    color: textColor ?? ColorManager.black,
                    fontSize: FontSize.s9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon(
      {Key? key,
      required this.count,
      this.filled = true,
      this.iconSize,
      this.onPressed,
      this.textColor})
      : super(key: key);
  final String count;
  final bool filled;
  final double? iconSize;
  final VoidCallback? onPressed;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return VideStatisticsItem(
      filled ? MimicIcons.favoriteFill : MimicIcons.favoriteOutline,
      count,
      iconSize: iconSize,
      onPressed: onPressed,
      filledColor: Theme.of(context).primaryColor,
      textColor: textColor ?? ColorManager.white,
    );
  }
}

class CommentIcon extends StatelessWidget {
  const CommentIcon(
      {Key? key,
      required this.count,
      this.iconSize,
      this.onPressed,
      this.textColor})
      : super(key: key);
  final String count;
  final double? iconSize;
  final VoidCallback? onPressed;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return VideStatisticsItem(
      MimicIcons.comments,
      count,
      iconSize: iconSize,
      onPressed: onPressed,
      filledColor: ColorManager.commentsColor,
      textColor: textColor ?? ColorManager.white,
    );
  }
}

class ViewIcon extends StatelessWidget {
  const ViewIcon(
      {Key? key,
      required this.count,
      this.iconSize,
      this.onPressed,
      this.textColor,
      this.iconColor})
      : super(key: key);
  final String count;
  final double? iconSize;
  final VoidCallback? onPressed;
  final Color? textColor;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return VideStatisticsItem(
      Icons.visibility,
      count,
      iconSize: iconSize,
      onPressed: onPressed,
      filledColor: iconColor ?? ColorManager.visibilityColor,
      textColor: textColor ?? ColorManager.white,
    );
  }
}

class ShareIcon extends StatelessWidget {
  const ShareIcon(
      {Key? key,
      required this.count,
      this.iconSize,
      this.onPressed,
      this.textColor,
      this.iconColor})
      : super(key: key);
  final String count;
  final double? iconSize;
  final VoidCallback? onPressed;
  final Color? textColor;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return VideStatisticsItem(
      Icons.share,
      count,
      iconSize: iconSize,
      onPressed: onPressed,
      filledColor: iconColor,
      textColor: textColor ?? ColorManager.white,
    );
  }
}
