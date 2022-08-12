import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/widgets/default_text_button.dart';

class ConfirmDeleteNotificationDialog extends StatelessWidget {
  const ConfirmDeleteNotificationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      title: Text('Are you sure from deleting this notification?',
      style: getMediumStyle(),),
      actions: 
      [
        defaultTextButton(onPressed: ()=>Navigator.pop(context,true), text: AppStrings.yes.translateString(context),
        buttonColor: Colors.green,textColor: ColorManager.white,),
        defaultTextButton(onPressed: ()=>Navigator.pop(context,false),
         text: AppStrings.no.translateString(context),buttonColor: ColorManager.error,
        
         textColor: ColorManager.white,),

      ],
    );
  }
}
