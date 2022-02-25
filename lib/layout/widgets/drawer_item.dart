import 'package:flutter/material.dart';
import 'package:mimic/layout/widgets/drawer_icon_image.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key,
      required this.onTap,
      required this.imagePath,
      this.iconColor,
      required this.title,
      this.iconSize})
      : super(key: key);
  final VoidCallback? onTap;
  final String imagePath;
  final Color? iconColor;
  final String title;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minLeadingWidth: 0,
      onTap: onTap,
      leading: DrawerIconImage(
        imagePath: imagePath,
        color: iconColor,
        size: iconSize,
      ),
      title: _titleBuilder(title),
    );
  }

  Widget _titleBuilder(String text) {
    return Text(
      text,
      style: getSemiBoldStyle(fontSize: FontSize.s11),
    );
  }
}
