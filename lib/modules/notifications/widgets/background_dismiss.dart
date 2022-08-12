import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/extentions/translate_word.dart';

class BackgroundDismiss extends StatelessWidget {
  const BackgroundDismiss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.error,
      alignment: AlignmentDirectional.centerEnd,
      padding: EdgeInsetsDirectional.only(
        end: 10.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.close,
            color: ColorManager.white,
          ),
          SizedBox(
            height: AppSize.s10,
          ),
          Text(
            AppStrings.delete.translateString(context),
            style: getMediumStyle(color: ColorManager.white),
          ),
        ],
      ),
    );
  }
}
