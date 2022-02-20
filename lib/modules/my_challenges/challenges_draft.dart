import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class ChallengesDraft extends StatelessWidget {
  const ChallengesDraft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 16,
      itemBuilder: (_, index) => const _DraftItem(),
    );
  }
}

class _DraftItem extends StatelessWidget {
  const _DraftItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0.h, horizontal: 8.w),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _draftItem(MimicIcons.draftTitle, 'Draft title')),
              VerticalDivider(
                thickness: 1,
                color: ColorManager.black,
              ),
              Expanded(
                  child: _draftItem(MimicIcons.draftCategory, 'Draft category'))
            ],
          ),
        ),
      ),
    );
  }

  Widget _draftItem(IconData icon, String title) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () => navigateTo(context, Routes.draft),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: ColorManager.visibilityColor, size: 25.r),
              SizedBox(width: 10.w),
              Text(
                title,
                softWrap: false,
                style: getSemiBoldStyle(),
              )
            ],
          ),
        ),
      );
    });
  }
}
