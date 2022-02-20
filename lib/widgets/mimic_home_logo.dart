import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MimicHomeLogo extends StatelessWidget {
  const MimicHomeLogo({Key? key, this.width, this.height}) : super(key: key);
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/images/home_logo.svg',
        height: height,
        width: width,
        fit: BoxFit.fill,
      ),
    );
  }
}
