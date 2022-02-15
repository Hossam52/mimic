import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';

class ImagesBuilder extends StatelessWidget {
  const ImagesBuilder({Key? key, required this.imagesCount}) : super(key: key);
  final int imagesCount;
  @override
  Widget build(BuildContext context) {
    const double imageRadius = 35;
    const double padding = 8;
    final imagesToRender = screenWidth(context) / ((imageRadius) * 2);
    int i = 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (i = 0; i < imagesToRender.toInt() - 1 && i < imagesCount; i++)
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/static/interest1.png'),
            radius: imageRadius,
          ),
        if (i < imagesCount) _lastImage(imageRadius, i),
      ],
    );
  }

  Stack _lastImage(double imageRadius, int i) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundImage:
              const AssetImage('assets/images/static/interest1.png'),
          radius: imageRadius,
        ),
        CircleAvatar(
            backgroundColor: ColorManager.black.withOpacity(0.60),
            radius: imageRadius),
        Center(
          child: Text(
            ' + ${imagesCount - i}',
            style: getSemiBoldStyle(color: ColorManager.white),
          ),
        ),
      ],
    );
  }
}
