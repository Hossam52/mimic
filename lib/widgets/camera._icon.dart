import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CameraIcon extends StatelessWidget {
  const CameraIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/camera.svg',
      width: 75.r,
      height: 75.r,
    );
  }
}
