import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/extentions/translate_word.dart';

class RequirementItem extends StatelessWidget {
  const RequirementItem({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${title.translateString(context)}: ',
          style: getSemiBoldStyle(),
        ),
        Text(
          '$value',
          style: getRegularStyle(color: ColorManager.primary),
        )
      ],
    );
  }
}
