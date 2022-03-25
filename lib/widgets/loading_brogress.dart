import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';

class LoadingProgress extends StatelessWidget {
  final Color? color;
  const LoadingProgress({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? ColorManager.primary,
      ),
    );
  }
}
