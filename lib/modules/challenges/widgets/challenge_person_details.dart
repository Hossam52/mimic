import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/rounded_image.dart';

class ChallengePersonDetails extends StatelessWidget {
  const ChallengePersonDetails({Key? key, this.textColor}) : super(key: key);
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
              child: RoundedImage(
            imagePath: 'assets/images/static/avatar.png',
          )),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ola ahmed',
                  style:
                      getSemiBoldStyle(color: textColor ?? ColorManager.white),
                ),
                Text(
                  '2 Min ago',
                  style: getRegularStyle(
                      color: textColor != null
                          ? Colors.grey
                          : ColorManager.white.withOpacity(0.56)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
