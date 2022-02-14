import 'package:flutter/material.dart';
import 'package:mimic/layout/auth/register_layout.dart';
import 'package:mimic/modules/auth/widgets/custom_pin_code.dart';
import 'package:mimic/modules/auth/widgets/stack_card_with_button.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/defulat_button.dart';

class RegisterVerifyEmailScreen extends StatelessWidget {
  const RegisterVerifyEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegisterLayout(
      contentFields: contentFields(context),
      displaySocialLogin: false,
    );
  }

  Widget contentFields(context) {
    final buttonHeight = screenHeight(context) * 0.07;
    return Column(
      children: [
        StackCardInButton(
          height: buttonHeight,
          button: DefaultButton(
            radius: 10,
            onPressed: () {
              navigateTo(context, Routes.interests);
            },
            text: 'Next',
            opacity: 0.7,
          ),
          content: Column(children: [
            const CustomPinCode(),
            _sentTo(context),
            const SizedBox(height: 10),
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
        _resendCode(),
      ],
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
              TextSpan(text: 'hossam@gmail.com', style: getBoldStyle())
            ],
          ),
        ),
        TextButton(
            onPressed: () {},
            style: ButtonStyle(
                foregroundColor:
                    getMaterialStateProperty(Theme.of(context).primaryColor)),
            child: const Text('Change email'))
      ],
    );
  }

  Widget _resendCode() {
    return InkWell(
      child: RichText(
        text: TextSpan(
          text: 'Didn\'t recieve code? ',
          style: getSemiBoldStyle(
              fontSize: FontSize.s16, color: ColorManager.white),
          children: [
            TextSpan(
                text: 'Resend',
                style: getBoldStyle(
                    fontSize: FontSize.s16, color: ColorManager.white))
          ],
        ),
      ),
    );
  }
}
