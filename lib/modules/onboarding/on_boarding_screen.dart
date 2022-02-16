import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({Key? key}) : super(key: key);
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            Expanded(
              flex: 3,
              child: _logo(),
            ),
            Expanded(child: _pages()),
            _Indicator(controller: _pageController),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  Widget _logo() {
    return Center(
      child: SvgPicture.asset(
        'assets/images/logo.svg',
      ),
    );
  }

  Widget _pages() {
    return Builder(builder: (context) {
      return PageView(
        controller: _pageController,
        children: const [
          Text(AppStrings.onboardingText1),
          Text(AppStrings.onboardingText2),
          Text(AppStrings.onboardingText3),
          Text(AppStrings.onboardingText4),
        ],
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          if (value == 3) navigateTo(context, Routes.guestMainLayout);
        },
      );
    });
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({Key? key, required this.controller}) : super(key: key);
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            navigateTo(context, Routes.guestMainLayout);
          },
          child: const Text('Skip'),
          style: _getButtonStyle(Theme.of(context).primaryColor),
        ),
        Expanded(
          child: Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: 4,
              effect: WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  radius: 6,
                  activeDotColor: Theme.of(context).primaryColor,
                  dotColor: Theme.of(context).disabledColor),
            ),
          ),
        ),
        TextButton(
            onPressed: () {
              controller.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.bounceIn);
            },
            child: const Text('Next'),
            style: _getButtonStyle(ColorManager.black)),
      ],
    );
  }

  ButtonStyle _getButtonStyle(Color color) {
    return ButtonStyle(
      foregroundColor: getMaterialStateProperty(color),
      textStyle: getMaterialStateProperty(
        getBoldStyle(color: color).copyWith(fontSize: 15),
      ),
    );
  }
}
