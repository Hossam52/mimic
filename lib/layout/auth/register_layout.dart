import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/layout/widgets/auth_layout_widget.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class RegisterLayout extends StatelessWidget {
  const RegisterLayout(
      {Key? key, required this.contentFields, this.displaySocialLogin = true})
      : super(key: key);
  final Widget contentFields;
  final bool displaySocialLogin;
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
          if (displaySocialLogin) Center(child: _orLoginWithSocial()),
          const SizedBox(height: 30),
          Center(child: _haveAccount()),
        ],
      );
    });
  }
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
        'Or\r\nRegister with',
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

Widget _haveAccount() {
  return InkWell(
    onTap: () {},
    child: RichText(
        text: const TextSpan(
            text: 'Have an account? ', children: [TextSpan(text: 'Login')])),
  );
}
