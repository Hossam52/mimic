import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:mimic/shared/cubits/helper_cubit/helper_cubit.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class ProfileChangePassword extends StatefulWidget {
  const ProfileChangePassword({Key? key}) : super(key: key);

  @override
  State<ProfileChangePassword> createState() => _ProfileChangePasswordState();
}

class _ProfileChangePasswordState extends State<ProfileChangePassword> {
  final passwordController = TextEditingController();

  final newPasswordController = TextEditingController();

  final newConfirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool passwordVisable = false;
  bool confirmPasswordVisable = false;

  @override
  Widget build(BuildContext context) {
    final double spaceAfterEnd = 10.h;
    return Scaffold(
      appBar: const TransparentAppBar(title: 'Change password'),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(44.0),
        child: Form(
          key: formKey,
          child: BlocProvider(
            create: (context) => HelperCubit(),
            child: BlocBuilder<HelperCubit, HelperState>(
              builder: (context, state) {
                return Column(
                  children: [
                    DefaultTextField(
                      isPassword: !HelperCubit.get(context).passwordVisiable,
                      borderRadius: 5.r,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Password';
                        } else if (value.length < 8) {
                          return 'Password is short';
                        }
                        return null;
                      },
                      hintText: 'Current Password',
                      controller: passwordController,
                      marginAfterEnd: spaceAfterEnd,
                      suffix: InkWell(
                          onTap: () =>
                              HelperCubit.get(context).togglePassword(),
                          child: Icon(!HelperCubit.get(context).passwordVisiable
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined)),
                      // icon: Icons.visibility_outlined,
                      iconColor: ColorManager.commentsColor,
                    ),
                    DefaultTextField(
                      isPassword:
                          !HelperCubit.get(context).confirmPasswordVisiable,
                      borderRadius: 5.r,
                      hintText: 'New Password',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your New Password';
                        } else if (value.length < 8) {
                          return 'Password is short';
                        } else if (newPasswordController.text !=
                            newConfirmPasswordController.text) {
                          return 'Password Mismatch';
                        }
                        return null;
                      },
                      controller: newPasswordController,
                      suffix: InkWell(
                          onTap: () =>
                              HelperCubit.get(context).toggleConfirmPassword(),
                          child: Icon(
                              !HelperCubit.get(context).confirmPasswordVisiable
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined)),
                      marginAfterEnd: spaceAfterEnd,
                      iconColor: ColorManager.commentsColor,
                    ),
                    DefaultTextField(
                      isPassword:
                          !HelperCubit.get(context).confirmPasswordVisiable,
                      borderRadius: 5.r,
                      hintText: 'Confirm New Password',
                      controller: newConfirmPasswordController,
                      marginAfterEnd: spaceAfterEnd,
                      action: TextInputAction.done,
                      suffix: InkWell(
                          onTap: () =>
                              HelperCubit.get(context).toggleConfirmPassword(),
                          child: Icon(
                              !HelperCubit.get(context).confirmPasswordVisiable
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Confirm Password';
                        } else if (value.length < 8) {
                          return 'Password is short';
                        } else if (newPasswordController.text !=
                            newConfirmPasswordController.text) {
                          return 'Password Mismatch';
                        }
                        return null;
                      },
                      iconColor: ColorManager.commentsColor,
                    ),
                    SizedBox(height: 30.h),
                    Opacity(
                      opacity: 0.7,
                      child: SvgPicture.asset(
                        'assets/images/logos/logo_vertical.svg',
                        width: double.infinity,
                        height: 220.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    SizedBox(
                      width: double.infinity,
                      child: BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthChangePasswordSuccess) {
                            Fluttertoast.showToast(
                                msg: state.message,
                                backgroundColor: Colors.green);
                            Navigator.pop(context);
                          } else if (state is AuthChangePasswordError) {
                            Fluttertoast.showToast(
                                msg: state.message,
                                backgroundColor: ColorManager.error);
                          }
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          return state is AuthChangePasswordLoading
                              ? const LoadingProgress()
                              : DefaultButton(
                                  text: 'Save Changes',
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      AuthCubit.get(context).changePassword(
                                          password: passwordController.text,
                                          newPassword:
                                              newPasswordController.text);
                                    }
                                  },
                                  width: double.infinity,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  foregroundColor: ColorManager.white,
                                  hasBorder: false,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  radius: 26.r,
                                );
                        },
                      ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                );
              },
            ),
          ),
        ),
      )),
    );
  }
}
