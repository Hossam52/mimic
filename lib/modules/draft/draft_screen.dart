import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/shared/services/pickers_services.dart';
import 'package:mimic/shared/services/video_services.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class DraftScreen extends StatelessWidget {
  const DraftScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(title: 'Draft'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
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
                        InkWell(
                          onTap: () async {
                            final videoPicked =
                                await PickerServices.pickVideo();
                            if (videoPicked != null) 
                            {
                              await VideoServices.processedVideo(videoPicked);
                            }
                          },
                          child: Container(
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
                                  SvgPicture.asset(
                                    'assets/images/upload.svg',
                                    width: 17.w,
                                    height: 17.w,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            DefaultButton(
              text: 'Publish',
              width: 200.w,
              onPressed: () {
                Dialogs.postForReviewDialog(context);
              },
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: ColorManager.white,
              hasBorder: false,
              radius: 7.r,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
