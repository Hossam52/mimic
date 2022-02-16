import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';

class PlayVideoIcon extends StatelessWidget {
  const PlayVideoIcon({Key? key, this.size = 30}) : super(key: key);
  final double size;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.play_circle_outline_outlined,
      size: size,
      color: ColorManager.white,
    );
  }
}
