import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/auth/register/register_virefy_email.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/prefix_icon_image.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(title: 'Forget Password'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         
          DefaultTextField(
              hintText: 'user@exmaple.com',
              controller: emailController,
              prefix:const  PrefixIconImage(
                  svgImagePath: 'assets/images/edit_profile_icons/email.svg'),
              labelText: 'Email',
              iconColor: Theme.of(context).primaryColor),
              SizedBox(height: 40.h,),
              DefaultButton(
                                  text: 'Save Changes',
                                  onPressed: () 
                                  {
                                    if (formKey.currentState!.validate()) 
                                    {
                                      navigateToWithoutNaming(context,const RegisterVerifyEmailScreen(login: true,));
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
                                )
        ],
      ),
    );
  }
}
