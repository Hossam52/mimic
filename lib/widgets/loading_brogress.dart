import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/assets_manager.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:lottie/lottie.dart';

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
class LoadingProgressSearchUsers extends StatelessWidget {
  const LoadingProgressSearchUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(LottieAssets.searchUsers),
    );
  }
}
class LoadingProgressSearchChallanges extends StatelessWidget {
  const LoadingProgressSearchChallanges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(LottieAssets.searchChallanges),
    );
  }
}
