import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class ChallengesDraft extends StatelessWidget {
  const ChallengesDraft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 48.h),
      child: ListView.builder(
        itemCount: 16,
        itemBuilder: (_, index) => const _DraftItem(),
      ),
    );
  }
}

class _DraftItem extends StatelessWidget {
  const _DraftItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateTo(context, Routes.draft),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.0.h, horizontal: 9.w),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: _draftItem(MimicIcons.draftTitle, 'Draft title')),
                VerticalDivider(
                  thickness: 1,
                  color: ColorManager.commentsColor.withOpacity(0.56),
                ),
                Expanded(
                    child: _draftItem(
                        MimicIcons.draftCategory, 'Draft category',
                        iconSize: 11))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _draftItem(IconData icon, String title, {double iconSize = 16}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: ColorManager.visibilityColor, size: iconSize.r),
          SizedBox(width: 10.w),
          Text(
            title,
            softWrap: false,
            style: getMediumStyle(fontSize: FontSize.s10),
          )
        ],
      ),
    );
  }
}
