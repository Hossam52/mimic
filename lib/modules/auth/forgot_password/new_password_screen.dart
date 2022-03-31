import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimic/layout/auth/login_layout.dart';
import 'package:mimic/modules/auth/widgets/stack_card_with_button.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final newPassword = TextEditingController();
  final confirmNewPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
    return Form(
      key: formKey,
      child: StackCardInButton(
        height: buttonHeight,
        button: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          if (state is AuthResetPasswordSuccess) {
            navigateAndFinish(context, Routes.login);
            Fluttertoast.showToast(msg: state.message);
          } else if (state is AuthResetPasswordError) 
          {
            Fluttertoast.showToast(
                msg: state.message, backgroundColor: ColorManager.error);
          }
        }, builder: (context, state) {
          return
          state is AuthResetPasswordLoading?const LoadingProgress(): 
              DefaultButton(
              radius: 10.r,
              onPressed: () 
              {
                if (formKey.currentState!.validate()) 
                {
                  AuthCubit.get(context).newPasswordAfterForget(
                      code: AuthCubit.get(context).forgetPasswordCode!,
                      password: newPassword.text);
                }
              },
              text: 'CONTINUE');
        }),
        content: Column(children: [
          DefaultTextField(
              hintText: 'New password',
              icon: Icons.lock_outline,
              isPassword: true,
               validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your New Password';
                        } else if (value.length < 8) {
                          return 'Password is short';
                        } else if (newPassword.text !=
                            confirmNewPassword.text) {
                          return 'Password Mismatch';
                        }
                        return null;
                      },
              controller: newPassword),
          DefaultTextField(
              hintText: 'Confirm password',
              icon: Icons.lock_outline,
              isPassword: true,
              validator: (value) 
              {
                        if (value!.isEmpty) 
                        {
                          return 'Please Enter Your Confirm Password';
                        } else if (value.length < 8) 
                        {
                          return 'Password is short';
                        } else if (newPassword.text !=
                            confirmNewPassword.text) 
                            {
                          return 'Password Mismatch';
                        }
                        return null;
                      },
              controller: confirmNewPassword),
           SizedBox(height: 10.h),
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
      ),
    );
  }
}
