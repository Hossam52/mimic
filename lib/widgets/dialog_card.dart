import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class DialogCard extends StatelessWidget {
  const DialogCard(
      {Key? key,
      required this.child,
      required this.headerTitle,
      this.backgroundColor,
      this.height})
      : super(key: key);
  final Widget child;
  final String headerTitle;
  final Color? backgroundColor;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: backgroundColor ?? ColorManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: height,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(context),
                  const Divider(),
                  Expanded(child: child),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Text(
          headerTitle,
          style: getBoldStyle(fontSize: FontSize.s16),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close, color: ColorManager.commentsColor),
            ),
          ),
        ),
      ],
    );
  }
}
