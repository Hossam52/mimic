import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [const BackgroundColor(), _data()],
      ),
    );
  }

  Widget _data() {
    return Builder(builder: (context) {
      return SingleChildScrollView(
        child: Column(
          children: [
            _logo(),
            _inputFields(context),
            _forgotPassword(),
            _orLoginWithSocial(),
            const SizedBox(height: 30),
            _dontHaveAccount(),
          ],
        ),
      );
    });
  }

  Widget _logo() {
    return SvgPicture.asset(
      'assets/images/logo.svg',
      fit: BoxFit.fill,
    );
  }

  Widget _inputFields(BuildContext context) {
    final totalHeight = screenHeight(context) * 0.42;
    final buttonHeight = screenHeight(context) * 0.07;
    final halfButtonHeight = buttonHeight / 2;
    final fieldsHeight = totalHeight - buttonHeight;
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          SizedBox(height: totalHeight),
          SizedBox(
            height: fieldsHeight,
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    const SizedBox(height: 20),
                    DefaultTextField(
                        hintText: 'Email', controller: TextEditingController()),
                    DefaultTextField(
                        hintText: 'Password',
                        isPassword: true,
                        controller: TextEditingController()),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: halfButtonHeight,
              right: 0,
              left: 0,
              child: SizedBox(
                  height: buttonHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: DefaultButton(
                        radius: 10, onPressed: () {}, text: 'Login'),
                  )))
        ],
      ),
    );
  }

  Widget _forgotPassword() {
    return TextButton(
        onPressed: () {},
        child: Text(
          'Forgot password?',
          style: getRegularStyle(
              fontSize: FontSize.s12, color: ColorManager.white),
        ));
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: socailImages
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(e),
                ),
              )
              .toList(),
        )
      ],
    );
  }

  Widget _dontHaveAccount() {
    return InkWell(
      onTap: () {},
      child: RichText(
          text: TextSpan(
              text: 'Doesn\'t have an account? ',
              children: [TextSpan(text: 'Register')])),
    );
  }
}

class BackgroundColor extends StatelessWidget {
  const BackgroundColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: screenHeight(context) * 0.42,
          color: ColorManager.white,
        ),
        Expanded(
          child: Container(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
