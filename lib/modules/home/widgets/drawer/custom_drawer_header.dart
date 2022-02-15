import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      height: screenHeight(context) * 0.18,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(80),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Row(
          children: [
            Icon(
              Icons.account_circle_rounded,
              color: ColorManager.white,
              size: 40,
            ),
            const SizedBox(width: 10),
            Text(
              'Guest user account',
              style: getBoldStyle(
                  fontSize: FontSize.s16, color: ColorManager.white),
            )
          ],
        ),
      ),
    );
  }
}
