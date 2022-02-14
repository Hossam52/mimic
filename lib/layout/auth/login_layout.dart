import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/layout/widgets/auth_layout_widget.dart';
import 'package:mimic/modules/auth/widgets/background_color_widget.dart';
import 'package:mimic/modules/auth/widgets/stack_card_with_button.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';

class LoginLayout extends StatelessWidget {
  const LoginLayout(
      {Key? key,
      required this.contentFields,
      this.displaySocialLogin = true,
      this.displayForgotPassword = true})
      : super(key: key);
  final Widget contentFields;
  final bool displaySocialLogin;
  final bool displayForgotPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AuthLayoutWidget(
          child: _data(),
        ),
      ),
    );
  }

  Widget _data() {
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          contentFields,
          if (displayForgotPassword) Center(child: _forgotPassword()),
          if (displaySocialLogin) Center(child: _orLoginWithSocial()),
          const SizedBox(height: 30),
          Center(child: _dontHaveAccount()),
        ],
      );
    });
  }
}

Widget _forgotPassword() {
  return Builder(builder: (context) {
    return TextButton(
        onPressed: () {
          navigateTo(context, Routes.forgetPassword);
        },
        child: Text(
          'Forgot password?',
          style: getRegularStyle(
              fontSize: FontSize.s12, color: ColorManager.white),
        ));
  });
}

Widget _orLoginWithSocial() {
  List<String> socailImages = [
    'assets/images/icons/gmail.svg',
    'assets/images/icons/facebook.svg',
    'assets/images/icons/instagram.svg',
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Or\r\nLogin with',
        textAlign: TextAlign.center,
        style: getRegularStyle(color: ColorManager.white),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: socailImages
            .map(
              (e) => SvgPicture.asset(e),
            )
            .toList(),
      )
    ],
  );
}

Widget _dontHaveAccount() {
  return Builder(builder: (context) {
    return InkWell(
      onTap: () {
        navigateTo(context, Routes.register);
      },
      child: RichText(
          text: const TextSpan(
              text: 'Doesn\'t have an account? ',
              children: [TextSpan(text: 'Register')])),
    );
  });
}