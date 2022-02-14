import 'package:flutter/material.dart';
import 'package:mimic/layout/auth/login_layout.dart';
import 'package:mimic/modules/auth/widgets/stack_card_with_button.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginLayout(
      contentFields: _inputFields(context),
      displayForgotPassword: false,
      displaySocialLogin: false,
    );
  }

  Widget _inputFields(BuildContext context) {
    final buttonHeight = screenHeight(context) * 0.07;
    return StackCardInButton(
      height: buttonHeight,
      button: DefaultButton(radius: 10, onPressed: () {}, text: 'CONTINUE'),
      content: Column(children: [
        DefaultTextField(
            hintText: 'New password',
            icon: Icons.lock_outline,
            isPassword: true,
            controller: TextEditingController()),
        DefaultTextField(
            hintText: 'Confirm password',
            icon: Icons.lock_outline,
            isPassword: true,
            controller: TextEditingController()),
        const SizedBox(height: 10),
      ]),
      header: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New password',
            style: getBoldStyle(fontSize: FontSize.s14),
          ),
          Text(
            'Plaease enter your new password',
            style: getSemiBoldStyle(
                fontSize: FontSize.s12, color: ColorManager.grey),
          ),
        ],
      ),
    );
  }
}
