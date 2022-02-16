import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class TransparentAppBar extends StatelessWidget with PreferredSizeWidget {
  const TransparentAppBar({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: getBoldStyle(fontSize: FontSize.s16),
      ),
      leading: BackButton(color: ColorManager.black),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
