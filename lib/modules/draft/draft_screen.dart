import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class DraftScreen extends StatelessWidget {
  const DraftScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(title: 'Draft'),
      body: Column(
        children: [
          Expanded(
              flex: 11,
              child: SizedBox(
                width: screenWidth(context),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DefaultTextField(
                          hintText: 'Challenge title',
                          controller: TextEditingController()),
                      DefaultTextField(
                          hintText: 'Choose category',
                          controller: TextEditingController()),
                      DefaultTextField(
                        hintText: 'Challenge details',
                        controller: TextEditingController(),
                        maxLines: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffBECBFF),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Upload your video',
                                style: getBoldStyle(),
                              ),
                              const Spacer(),
                              Icon(Icons.upload_sharp,
                                  size: 20.r,
                                  color: ColorManager.visibilityColor),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          DefaultButton(
            text: 'Publish',
            onPressed: () {},
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: ColorManager.white,
            hasBorder: false,
            radius: 7.r,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
