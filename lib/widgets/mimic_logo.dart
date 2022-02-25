import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MimicLogoHorizontal extends StatelessWidget {
  const MimicLogoHorizontal({Key? key, this.width, this.height})
      : super(key: key);
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/images/logos/logo_horizontal.svg',
        height: height,
        width: width,
        fit: BoxFit.fill,
      ),
    );
  }
}

class MimicLogoVertical extends StatelessWidget {
  const MimicLogoVertical({Key? key, this.width, this.height})
      : super(key: key);
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/images/logo.svg',
        height: height,
        width: width,
        fit: BoxFit.fill,
      ),
    );
  }
}
