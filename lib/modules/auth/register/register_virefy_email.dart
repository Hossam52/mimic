
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimic/layout/auth/register_layout.dart';
import 'package:mimic/modules/auth/widgets/custom_pin_code.dart';
import 'package:mimic/modules/auth/widgets/stack_card_with_button.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class RegisterVerifyEmailScreen extends StatefulWidget {
  const RegisterVerifyEmailScreen({Key? key, this.login = false})
      : super(key: key);
  final bool login;
  @override
  State<RegisterVerifyEmailScreen> createState() =>
      _RegisterVerifyEmailScreenState();
}

class _RegisterVerifyEmailScreenState extends State<RegisterVerifyEmailScreen> {
  final buttonHeight = 0.07.sh;
  final formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return RegisterLayout(
      contentFields: contentFields(context),
      displaySocialLogin: false,
    );
  }

  Widget contentFields(context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          StackCardInButton(
            height: buttonHeight,
            button: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthActiviteSuccess) {
                  navigateAndFinish(context, Routes.login);
                  navigateTo(context, Routes.interests);
                } else if (state is AuthActiviteError) {
                  Fluttertoast.showToast(
                      msg: state.message,
                      backgroundColor: ColorManager.error,
                      fontSize: FontSize.s16);
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                return DefaultButton(
                  radius: 10.r,
                  loading: state is AuthActiviteLoading,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      AuthCubit.get(context)
                          .verifyAccount(code: codeController.text);
                    }
                  },
                  text: 'Next',
                  opacity: 0.7,
                );
              },
            ),
            content: Column(children: [
              CustomPinCode(codeController: codeController),
              _sentTo(context),
              SizedBox(height: 10.h),
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
              TextSpan(
                  text: AuthCubit.get(context).email, style: getBoldStyle())
            ],
          ),
        ),
        if (!widget.login)
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                  foregroundColor:
                      getMaterialStateProperty(Theme.of(context).primaryColor)),
              child: const Text('Change email'))
      ],
    );
  }

  Widget _resendCode() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthResendCodeError) {
          Fluttertoast.showToast(
              msg: state.message, backgroundColor: ColorManager.error);
        } else if (state is AuthResendCodeSuccess) {
          Fluttertoast.showToast(
              msg: state.message, backgroundColor: ColorManager.accentColor);
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            AuthCubit.get(context).resendCodeToAccount();
          },
          child: state is AuthResendCodeLoading
              ? const LoadingProgress(
                  color: Colors.white,
                )
              : RichText(
                  text: TextSpan(
                    text: 'Didn\'t recieve code? ',
                    style: getSemiBoldStyle(
                        fontSize: FontSize.s16, color: ColorManager.white),
                    children: [
                      TextSpan(
                          text: 'Resend',
                          style: getBoldStyle(
                              fontSize: FontSize.s16,
                              color: ColorManager.white))
                    ],
                  ),
                ),
        );
      },
    );
  }
}
