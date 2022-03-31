import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrefixIconImage extends StatelessWidget {
  const PrefixIconImage({Key? key, required this.svgImagePath, this.size = 15})
      : super(key: key);
  final String svgImagePath;
  final double size;
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: SizedBox(
        width: size.w,
        height: size.w,
        child: FittedBox(
          child: SvgPicture.asset(
            svgImagePath,
          ),
        ),
      ),
    );
  }
}