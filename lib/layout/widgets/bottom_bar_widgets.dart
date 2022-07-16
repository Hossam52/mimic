import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/presentation/resourses/assets_manager.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class _BottomBarWidgetIcon extends StatelessWidget {
  const _BottomBarWidgetIcon({Key? key, required this.icon}) : super(key: key);
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: ColorManager.commentsColor,
      size: 27.r,
    );
  }
}

class HomeBottomBarWidget extends StatelessWidget {
  const HomeBottomBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _BottomBarWidgetIcon(icon: MimicIcons.homeBottomTab);
  }
}

class SearchBottomBarWidget extends StatelessWidget {
  const SearchBottomBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _BottomBarWidgetIcon(icon: MimicIcons.discoverBottomTab);
  }
}

class AddChallengeBottomBarWidget extends StatelessWidget {
  const AddChallengeBottomBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37.h,
      width: 37.h,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding:  EdgeInsets.all(4.0.r),
        child: SvgPicture.asset(ImageAssets.add),
      ),
      // Icon(
      //   Icons.add,
      //   color: ColorManager.white,
      //   size: 37.r,
      // ),
    );
  }
}

class ChallengesBottomBarWidget extends StatelessWidget {
  const ChallengesBottomBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _BottomBarWidgetIcon(icon: MimicIcons.challenges);
  }
}

class AccountBottomBarWidget extends StatelessWidget {
  const AccountBottomBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 50.h,
      child: SvgPicture.asset(
        ImageAssets.accountBottomTab,
        color: ColorManager.commentsColor,
      ),
    );
    return const _BottomBarWidgetIcon(icon: MimicIcons.account);
  }
}
