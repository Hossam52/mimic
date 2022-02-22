import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class CustomerSupportScreen extends StatelessWidget {
  const CustomerSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Customer services'),
        titleTextStyle: getBoldStyle(fontSize: FontSize.s14),
        leading: BackButton(color: ColorManager.black),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            const _Background(),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight(context) * 0.22),
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.all(8),
                      child: const _InputFields()),
                  const SizedBox(height: 30),
                  const _SendButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          height: screenHeight(context) * 0.3,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Image.asset(
            'assets/images/customer_service.png',
            fit: BoxFit.fill,
          ),
        ),
        Expanded(
            child: Container(
          color: ColorManager.white,
        )),
      ],
    );
  }
}

class _InputFields extends StatelessWidget {
  const _InputFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          DefaultTextField(
              hintText: 'Name',
              iconColor: Theme.of(context).primaryColor,
              controller: TextEditingController(),
              icon: MimicIcons.accountfilled),
          DefaultTextField(
              hintText: 'Mobile',
              iconColor: Theme.of(context).primaryColor,
              controller: TextEditingController(),
              icon: Icons.phone),
          DefaultTextField(
              hintText: 'Email',
              iconColor: Theme.of(context).primaryColor,
              controller: TextEditingController(),
              icon: MimicIcons.email),
          DefaultTextField(
              hintText: 'Problem description',
              maxLines: 6,
              iconColor: Theme.of(context).primaryColor,
              controller: TextEditingController(),
              prefixIcon: MimicIcons.problem),
        ],
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 90.0.w),
      child: SizedBox(
        width: double.infinity,
        child: DefaultButton(
          text: 'Send',
          onPressed: () {},
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: ColorManager.white,
          radius: 15.r,
        ),
      ),
    );
  }
}
