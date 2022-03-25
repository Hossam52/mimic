import 'package:flutter/material.dart';
import 'package:mimic/layout/auth/login_layout.dart';
import 'package:mimic/modules/auth/widgets/custom_pin_code.dart';
import 'package:mimic/modules/auth/widgets/stack_card_with_button.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

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
    return StackCardInButton(
      height: buttonHeight,
      button: DefaultButton(
        radius: 10,
        onPressed: () {
          navigateTo(context, Routes.newPassword);
        },
        text: 'Next',
        opacity: 0.7,
      ),
      content: Column(children: [
         CustomPinCode(codeController: TextEditingController()),
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
}
