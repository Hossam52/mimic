import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class TransparentAppBar extends StatelessWidget with PreferredSizeWidget {
  const TransparentAppBar({Key? key, required this.title, this.backColor})
      : super(key: key);
  final String title;
  final Color? backColor;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: getSemiBoldStyle(fontSize: FontSize.s14),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_sharp,
            color: backColor ?? ColorManager.backButtonColor),
        iconSize: 25.r,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
