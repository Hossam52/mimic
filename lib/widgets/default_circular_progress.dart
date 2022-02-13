import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';

class DefaultCircularProgress extends StatelessWidget {
  const DefaultCircularProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Loading ...',
          style: TextStyle(fontSize: 16, color: ColorManager.white),
        ),
        CircularProgressIndicator(
          color: ColorManager.primary,
        ),
      ],
    );
  }
}
