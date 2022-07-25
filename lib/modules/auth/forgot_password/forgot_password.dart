import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/layout/auth/login_layout.dart';
import 'package:mimic/modules/auth/widgets/custom_pin_code.dart';
import 'package:mimic/modules/auth/widgets/stack_card_with_button.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/defulat_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController code = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoginLayout(
      contentFields: contentFields(context),
      displayForgotPassword: false,
      displaySocialLogin: false,
    );
  }

  Widget contentFields(context) {
    final buttonHeight = screenHeight(context) * 0.07;
    return Form(
      key: formKey,
      child: StackCardInButton(
        height: buttonHeight,
        button: DefaultButton(
          radius: 10.r,
          onPressed: () {
            if (formKey.currentState!.validate()) 
            {
              AuthCubit.get(context).setForgetPasswordCode(code: code.text);
              navigateTo(context, Routes.newPassword, arguments: code.text);
            }
          },
          text: 'Next',
          opacity: 0.7,
        ),
        content: Column(children: [
          CustomPinCode(codeController: code),
          _sentTo(context),
          SizedBox(height: 10.h),
        ]),
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verify email',
              style: getBoldStyle(fontSize: FontSize.s14),
            ),
            Text(
              'Please Enter verification code',
              style: getSemiBoldStyle(
                  fontSize: FontSize.s12, color: ColorManager.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sentTo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'We have sent it to e-mail: ',
            style: getRegularStyle(),
            children: [
              TextSpan(
                text: AuthCubit.get(context).forgetPasswordEmail,
                style: getBoldStyle(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
