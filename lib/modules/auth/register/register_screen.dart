import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/layout/auth/register_layout.dart';
import 'package:mimic/modules/auth/widgets/stack_card_with_button.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RegisterLayout(contentFields: _inputFields(context));
  }

  Widget _inputFields(BuildContext context) {
    final buttonHeight = 0.07.sh;
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return StackCardInButton(
      height: buttonHeight,
      button: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthRegisterError) {
            Fluttertoast.showToast(
              msg: state.message,
              backgroundColor: ColorManager.error,
              fontSize: FontSize.s16,
            );
          } else if (state is AuthRegisterSuccess) {
            navigateTo(context, Routes.registerVerifyEmail,);
          }
        },
        builder: (context, state) {
          return DefaultButton(
            radius: 10.r,
            loading: state is AuthRegisterLoading,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                AuthCubit.get(context).registerAccount(
                    username: usernameController.text,
                    email: emailController.text,
                    password: passwordController.text,);
              }
            },
            text: 'CONTINUE',
          );
        },
      ),
      content: Form(
        key: formKey,
        child: Column(children: [
          DefaultTextField(
              hintText: 'Email',
              icon: Icons.email_outlined,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Your Email';
                } else if (!EmailValidator.validate(value)) {
                  return 'Please Enter Valid Email';
                } else {
                  return null;
                }
              },
              controller: emailController),
          DefaultTextField(
              hintText: 'User name ',
              icon: Icons.person_outline,
              validator: (username) {
                if (username!.isNotEmpty && username.length > 4) {
                  return null;
                } else if (username.isEmpty) {
                  return 'Please Enter Your Username';
                } else {
                  return 'username is short';
                }
              },
              controller: usernameController),
          DefaultTextField(
              hintText: 'Password',
              icon: Icons.lock_outline,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Your Password';
                } else if (value.length < 8) {
                  return 'Password is short';
                } else if (passwordController.text !=
                    confirmPasswordController.text) {
                  return 'Password Mismatch';
                }
                return null;
              },
              isPassword: true,
              controller: passwordController),
          DefaultTextField(
              hintText: 'Confirm Password',
              icon: Icons.lock_outline,
              isPassword: true,
              action: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Your Confirm Password';
                } else if (value.length < 8) {
                  return 'Password is short';
                } else if (passwordController.text !=
                    confirmPasswordController.text) {
                  return 'Password Mismatch';
                }
                return null;
              },
              controller: confirmPasswordController),
          const SizedBox(height: 10),
        ]),
      ),
      header: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Register',
            style: getBoldStyle(fontSize: FontSize.s14),
          ),
          Text(
            'Please enter you info',
            style: getSemiBoldStyle(
                fontSize: FontSize.s12, color: ColorManager.grey),
          ),
        ],
      ),
    );
  }
}
