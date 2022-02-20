import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/modules/my_challenges/widgets/all_categories_drop_down.dart';
import 'package:mimic/modules/my_challenges/widgets/my_challenge_item.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/widgets/custom_drop_down.dart';
import 'package:mimic/widgets/play_video_icon.dart';
import 'package:mimic/widgets/rounded_image.dart';
import 'package:mimic/widgets/shadow_box.dart';

class RejectedChallenges extends StatelessWidget {
  const RejectedChallenges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          const AllCategoriesDropDown(),
          Expanded(child: _rejectedChallenges()),
        ],
      ),
    );
  }

  Widget _rejectedChallenges() {
    return ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Dialogs.showRejectedVideoReason(context);
              },
              child: const MyChallengeItem());
        });
  }
}
