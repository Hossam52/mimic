import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/defulat_button.dart';

class AcceptChallengeDialog extends StatelessWidget {
  const AcceptChallengeDialog({Key? key,required this.confirm,}) : super(key: key);
  final Function confirm;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 46.h, horizontal: 25.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure to approve this challenge?',
              style: getSemiBoldStyle(fontSize: FontSize.s14),
            ),
            SizedBox(height: 46.h),
            //
            _AcceptActions(confirm: confirm),
          ],
        ),
      ),
    );
  }
}

class RejectChallengeDialog extends StatelessWidget {
  const RejectChallengeDialog({
    Key? key,
    required this.confirmCancel,
  }) : super(key: key);
  final Function confirmCancel;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 46.h, horizontal: 25.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure to reject this challenge?',
              style: getSemiBoldStyle(fontSize: FontSize.s14),
            ),
            SizedBox(height: 46.h),
            _AcceptActions(
              confirm: confirmCancel,
            ),
          ],
        ),
      ),
    );
  }
}

class _AcceptActions extends StatelessWidget {
  const _AcceptActions({Key? key, required this.confirm}) : super(key: key);
  final Function confirm;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DefaultButton(
              text: 'OK',
              onPressed: () {
                confirm();
                Navigator.pop(context);
              },
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: ColorManager.white,
              radius: 12.r),
        ),
        SizedBox(width: 11.w),
        Expanded(
          child: DefaultButton(
              text: 'Cancel',
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: ColorManager.white,
              foregroundColor: ColorManager.black,
              hasBorder: false,
              radius: 12.r),
        ),
      ],
    );
  }
}
