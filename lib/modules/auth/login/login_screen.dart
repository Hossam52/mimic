import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/layout/auth/login_layout.dart';
import 'package:mimic/modules/auth/widgets/stack_card_with_button.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginLayout(contentFields: _inputFields(context));
  }

  Widget _inputFields(BuildContext context) {
    final buttonHeight = screenHeight(context) * 0.07;
    return StackCardInButton(
      height: buttonHeight,
      button: DefaultButton(
          radius: 10,
          onPressed: () {
            navigateReplacement(context, Routes.userMainLayout);
          },
          text: 'Login'),
      content: Column(children: [
        DefaultTextField(
            hintText: 'Email',
            icon: Icons.email_outlined,
            controller: TextEditingController()),
        DefaultTextField(
            hintText: 'Password',
            icon: Icons.lock_outline,
            isPassword: true,
            controller: TextEditingController()),
        const SizedBox(height: 10),
      ]),
      header: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style: getBoldStyle(fontSize: FontSize.s14),
          ),
          Text(
            'Please login to your account',
            style: getSemiBoldStyle(
                fontSize: FontSize.s12, color: ColorManager.grey),
          ),
        ],
      ),
    );
  }
}
