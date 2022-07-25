import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/layout/widgets/rounded_drawer_header.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class GuestCustomDrawerHeader extends StatelessWidget {
  const GuestCustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedDrawerHeader(
      child: Row(
        children: [
          SvgPicture.asset('assets/images/guest_icon.svg'),
          const SizedBox(width: 10),
          Text(
            'Guest user',
            style:
                getBoldStyle(fontSize: FontSize.s16, color: ColorManager.white),
          )
        ],
      ),
    );
  }
}
