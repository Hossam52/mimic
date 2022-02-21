import 'package:flutter/material.dart';
import 'package:mimic/layout/guest/error_guest_permissions.dart';
import 'package:mimic/layout/guest/guest_main_layout.dart';
import 'package:mimic/layout/user/user_main_layout.dart';
import 'package:mimic/modules/auth/forgot_password/new_password_screen.dart';
import 'package:mimic/modules/auth/forgot_password/forgot_password.dart';
import 'package:mimic/modules/auth/login/login_screen.dart';
import 'package:mimic/modules/auth/register/interests/interests_screen.dart';
import 'package:mimic/modules/auth/register/register_screen.dart';
import 'package:mimic/modules/auth/register/register_virefy_email.dart';
import 'package:mimic/modules/auth/register/terms_conditions/privacy_policy_screen.dart';
import 'package:mimic/modules/challenges/all_challengers/all_challengers.dart';
import 'package:mimic/modules/challenges/challenge_details/challenge_details.dart';
import 'package:mimic/modules/challenges/challenger_video/challenger_video.dart';
import 'package:mimic/modules/draft/draft_screen.dart';
import 'package:mimic/modules/home/customer_support.dart';
import 'package:mimic/modules/home/home_screen.dart';
import 'package:mimic/modules/home/how_to_challenge.dart';
import 'package:mimic/modules/my_profile/profile_change_password.dart';
import 'package:mimic/modules/my_profile/profile_settings.dart';
import 'package:mimic/modules/search/scan_qr.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoarding = "/onboarding";
  static const String login = "/login";
  static const String newPassword = "/new_password";
  static const String register = "/register";
  static const String registerVerifyEmail = "/register_verify_email";
  static const String interests = "/interests";
  static const String privacyPolicy = "/privacy_policy";
  static const String main = "/main";
  static const String forgetPassword = "/forget_password";
  static const String customerSupport = "/customer_support";
  static const String howToChallenge = "/how_to_challenge";
  static const String errorGuestPermissions = "/error_guest_permission";
  static const String userMainLayout = '/user_main_layout';
  static const String guestMainLayout = '/guest_main_layout';
  static const String challengeDetails = '/challenge_details';
  static const String allChallengers = '/all_challengers';
  static const String challengerVideo = '/challenger_video';
  static const String scanQr = '/scan_qr';
  static const String draft = '/draft';
  static const String profileSettings = '/profile_settings';
  static const String profileChangePassword = '/profile_change_password';
}

class RouteGenerator {
  static Route<T> getRoute<T>(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case Routes.newPassword:
        return MaterialPageRoute(builder: (_) => const NewPasswordScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.registerVerifyEmail:
        return MaterialPageRoute(
            builder: (_) => const RegisterVerifyEmailScreen());
      case Routes.interests:
        return MaterialPageRoute(builder: (_) => const InterestsScreen());
      case Routes.privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
      // case Routes.main:
      //   return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.customerSupport:
        return MaterialPageRoute(builder: (_) => const CustomerSupportScreen());
      case Routes.howToChallenge:
        return MaterialPageRoute(builder: (_) => const HowToChallengeScreen());
      case Routes.errorGuestPermissions:
        return MaterialPageRoute(builder: (_) => const ErrorGuestPermission());
      case Routes.userMainLayout:
        return MaterialPageRoute(builder: (_) => const UserMainLayout());
      case Routes.guestMainLayout:
        return MaterialPageRoute(builder: (_) => const GuestMainLayout());
      case Routes.challengeDetails:
        return MaterialPageRoute(
            builder: (_) => const ChallengeDetailsScreen());
      case Routes.allChallengers:
        return MaterialPageRoute(builder: (_) => const AllChallengers());
      case Routes.challengerVideo:
        return MaterialPageRoute(builder: (_) => const ChallengerVideo());
      case Routes.scanQr:
        return MaterialPageRoute(builder: (_) => const ScanQrScreen());
      case Routes.draft:
        return MaterialPageRoute(builder: (_) => const DraftScreen());
      case Routes.profileSettings:
        return MaterialPageRoute(builder: (_) => const ProfileSettings());
      case Routes.profileChangePassword:
        return MaterialPageRoute(builder: (_) => const ProfileChangePassword());

      default:
        return unDefinedRoute();
    }
  }

  static Route<T> unDefinedRoute<T>() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
