import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimic/layout/auth/login_layout.dart';
import 'package:mimic/modules/auth/register/register_virefy_email.dart';
import 'package:mimic/modules/auth/widgets/stack_card_with_button.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:mimic/shared/helpers/helper_methods.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return LoginLayout(
        contentFields: Form(key: formKey, child: _inputFields(context)));
  }

  Widget _inputFields(BuildContext context) {
    final buttonHeight = 0.07.sh;
    return StackCardInButton(
      height: buttonHeight,
      button: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginError) {
            Fluttertoast.showToast(
                msg: state.message,
                backgroundColor: ColorManager.error,
                fontSize: FontSize.s16);
          } else if (state is AuthLoginSuccess) {
            navigateReplacement(context, Routes.userMainLayout);
          } else if (state is AuthNavigateFillIntrestesState) {
            navigateTo(context, Routes.interests);
          } else if (state is AuthNavigateToVerifiyState) {
            navigateToWithoutNaming(context,const RegisterVerifyEmailScreen(login: true),
             );
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return state is AuthLoginLoading
              ? const LoadingProgress()
              : DefaultButton(
                  radius: 10.r,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      HelperMethods.closeKeyboard(context);
                      AuthCubit.get(context).loginAccount(
                          email: emailController.text,
                          password: passwordController.text);
                    }
                  },
                  text: 'Login');
        },
      ),
      content: Column(children: [
        DefaultTextField(
            hintText: 'Email',
            node: emailFocus,
            icon: Icons.email_outlined,
            validator: (value) => HelperMethods.validateEmail(value),
            controller: emailController),
        DefaultTextField(
            hintText: 'Password',
            action: TextInputAction.done,
            node: passwordFocus,
            icon: Icons.lock_outline,
            isPassword: true,
            controller: passwordController),
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
