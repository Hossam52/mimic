import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/shared/methods.dart';

class BackgroundColorWidget extends StatelessWidget {
  const BackgroundColorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: screenHeight(context) * 0.42,
          color: ColorManager.white,
        ),
        Expanded(
          child: Container(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
