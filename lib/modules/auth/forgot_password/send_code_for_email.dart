import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:mimic/shared/helpers/helper_methods.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/loading_brogress.dart';
import 'package:mimic/widgets/prefix_icon_image.dart';

class SendCodeForEmailForgetScreen extends StatefulWidget {
  const SendCodeForEmailForgetScreen({Key? key}) : super(key: key);

  @override
  State<SendCodeForEmailForgetScreen> createState() =>
      _SendCodeForEmailForgetScreenState();
}

class _SendCodeForEmailForgetScreenState
    extends State<SendCodeForEmailForgetScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(title: 'Forget Password'),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextField(
                  hintText: 'user@exmaple.com',
                  controller: emailController,
                  prefix: const PrefixIconImage(
                      svgImagePath:
                          'assets/images/edit_profile_icons/email.svg'),
                  labelText: 'Email',
                  validator: (value) => HelperMethods.validateEmail(value),
                  iconColor: Theme.of(context).primaryColor),
              SizedBox(
                height: 40.h,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthForgetPasswordSuccess) {
                    Fluttertoast.showToast(msg: state.message);
                    navigateTo(context, Routes.forgetPassword);
                  } else if (state is AuthForgetPasswordError) {
                    Fluttertoast.showToast(
                        msg: state.message,
                        backgroundColor: ColorManager.error);
                  }
                },
                builder: (context, state) {
                  return state is AuthForgetPasswordLoading
                      ? const LoadingProgress()
                      : DefaultButton(
                          text: 'Confirm',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AuthCubit.get(context).sendCodeForgetPassword(
                                  email: emailController.text);
                            }
                          },
                          width: double.infinity,
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: ColorManager.white,
                          hasBorder: false,
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          radius: 26.r,
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
