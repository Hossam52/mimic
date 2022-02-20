import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/shared/methods.dart';

class RoundedDrawerHeader extends StatelessWidget {
  const RoundedDrawerHeader({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      height: screenHeight(context) * 0.18,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(100),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0.h, horizontal: 10.w),
          child: child),
    );
  }
}
