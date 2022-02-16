import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

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
          Expanded(child: _roundedImage()),
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

  Widget _roundedImage() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Image.asset(
        'assets/images/static/avatar.png',
        width: 40,
        height: 40,
        fit: BoxFit.contain,
      ),
    );
  }
}
