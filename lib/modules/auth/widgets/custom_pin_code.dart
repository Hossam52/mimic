import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCode extends StatelessWidget {
  final TextEditingController codeController;
  const CustomPinCode({Key? key, required this.codeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      
      controller: codeController,
      hintCharacter: '*',
      hintStyle: getBoldStyle(fontSize: FontSize.s16, color: ColorManager.grey),
      textStyle: getRegularStyle(),
      validator: (value) {
        if (value!.length < 4) return 'Please Enter All Of Code';
        return null;
      },
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      animationType: AnimationType.fade,
      animationCurve: Curves.bounceInOut,
      pinTheme: PinTheme(
        activeFillColor: ColorManager.lightGrey,
        selectedFillColor: ColorManager.grey,
        borderRadius: BorderRadius.circular(10.r),
        activeColor: ColorManager.grey,
        inactiveColor: ColorManager.grey,
        shape: PinCodeFieldShape.box,
      ),
      length: 4,
      onChanged: (val) {},
    );
  }
}
