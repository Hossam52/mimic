import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/camera._icon.dart';
import 'package:mimic/widgets/gallery_icon.dart';

class CreateChallenge extends StatelessWidget {
  const CreateChallenge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(title: 'Create New Challenge'),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(35.r),
              child: SizedBox(
                height: 580.h,
                width: double.infinity,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/static/create_challenge.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,
                    ),

                    BlackOpacity(),
                    // Container(
                    //   height: double.infinity,
                    //   width: double.infinity,
                    //   color: Colors.red,
                    // )
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Expanded(child: _challengeActions(context)),
          ],
        ),
      ),
    );
  }

  Widget _challengeActions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(children: [
        const Expanded(
            child: Align(
          alignment: Alignment.centerLeft,
          child: GalleryIcon(),
        )),
        GestureDetector(
            onTap: () {
              navigateTo(context, Routes.draft);
            },
            child: const CameraIcon()),
        const Spacer(),
      ]),
    );
  }
}
