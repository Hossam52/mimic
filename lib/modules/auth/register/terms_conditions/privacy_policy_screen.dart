import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_check_box.dart';
import 'package:mimic/widgets/defulat_button.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool accept = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Choose your interests'),
        titleTextStyle: getBoldStyle(fontSize: FontSize.s16),
        elevation: 0,
        leading: BackButton(color: ColorManager.black),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(
            flex: 10,
            child: SingleChildScrollView(child: _privacyRules()),
          ),
          _acceptRules(),
          const Spacer(),
          DefaultButton(
            text: 'Finish',
            onPressed: () {
              navigateAndFinish(context, Routes.userMainLayout);
            },
            hasBorder: false,
            radius: 15.r,
            disabledColor: ColorManager.primary.withOpacity(0.5),
            foregroundColor: ColorManager.white,
            backgroundColor: Theme.of(context).primaryColor,
            trailing: const Icon(Icons.arrow_forward),
          )
        ]),
      ),
    );
  }

  Widget _privacyRules() {
    return Text(
      AppStrings.privacyPolicyRules,
      style: getRegularStyle(color: ColorManager.lightGrey).copyWith(
        height: 2.5,
        wordSpacing: 1,
        letterSpacing: 1,
      ),
    );
  }

  Widget _acceptRules() {
    return DefaultCheckbox(
      val: accept,
      text: 'I accept mimic rules',
      onChange: (val) {
        setState(() {
          accept = val!;
        });
      },
    );
  }
}
