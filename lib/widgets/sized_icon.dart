import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizedIcon extends StatelessWidget {
  const SizedIcon(this.icon, {Key? key, required, this.size, this.color})
      : super(key: key);
  final IconData icon;
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size ?? 18.r,
      color: color,
    );
  }
}
