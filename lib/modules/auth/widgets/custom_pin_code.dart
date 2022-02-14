import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCode extends StatelessWidget {
  const CustomPinCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      obscureText: true,
      hintCharacter: '*',
      hintStyle: getBoldStyle(fontSize: FontSize.s16, color: ColorManager.grey),
      textStyle: getRegularStyle(),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      animationType: AnimationType.fade,
      animationCurve: Curves.bounceInOut,
      pinTheme: PinTheme(
        activeFillColor: ColorManager.lightGrey,
        selectedFillColor: ColorManager.grey,
        borderRadius: BorderRadius.circular(10),
        activeColor: ColorManager.grey,
        inactiveColor: ColorManager.grey,
        shape: PinCodeFieldShape.box,
      ),
      length: 4,
      onChanged: (val) {},
    );
  }
}
