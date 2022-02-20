import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/defulat_button.dart';

class ErrorGuestPermission extends StatelessWidget {
  const ErrorGuestPermission({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/static/error_guest_permissions.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          const BlackOpacity(opacity: 0.46),
          const _SorryCard(),
        ],
      ),
    );
  }
}

class _SorryCard extends StatelessWidget {
  const _SorryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: screenWidth(context) * 0.7,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ColorManager.white.withOpacity(0.8)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              color: ColorManager.grey.withOpacity(0.8),
              child: Center(
                child: Text(
                  'Sorry !',
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SvgPicture.asset('assets/images/explanation_mark.svg'),
                  const SizedBox(height: 15),
                  Text(
                    'Sorry! You Have To Register',
                    style: getBoldStyle(),
                  ),
                  const SizedBox(height: 40),
                  DefaultButton(
                    text: 'Register',
                    onPressed: () {
                      navigateTo(context, Routes.register);
                    },
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: ColorManager.white,
                    radius: 5,
                  ),
                  const SizedBox(height: 10),
                  DefaultButton(
                    text: 'Login',
                    hasBorder: false,
                    onPressed: () {
                      navigateTo(context, Routes.login);
                    },
                    foregroundColor: ColorManager.black,
                    radius: 5,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
