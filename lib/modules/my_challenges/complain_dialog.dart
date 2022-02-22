import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class ComplainDialog extends StatelessWidget {
  const ComplainDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text(
                'Admin rejected your video',
                style: getSemiBoldStyle(
                    fontSize: FontSize.s14,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 210.h,
              child: SingleChildScrollView(
                child: Text(
                  AppStrings.rejectedReason,
                  style: getRegularStyle(),
                ),
              ),
            ),
            const _RejectedActions(),
            RichText(
              text: TextSpan(
                text: 'If You Have Something To Say Press ',
                style: getRegularStyle(
                    color: ColorManager.complain.withOpacity(0.57)),
                children: [
                  TextSpan(
                    text: 'Complain',
                    style: getBoldStyle(color: ColorManager.complain),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class _RejectedActions extends StatefulWidget {
  const _RejectedActions({Key? key}) : super(key: key);

  @override
  _RejectedActionsState createState() => _RejectedActionsState();
}

class _RejectedActionsState extends State<_RejectedActions> {
  bool displayComplainTextField = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
      child: displayComplainTextField
          ? _textField()
          : Row(
              children: [
                Expanded(
                  flex: 4,
                  child: DefaultButton(
                    height: screenHeight(context) * 0.06,
                    text: 'Ok',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: ColorManager.white,
                    radius: 10,
                    hasBorder: false,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: DefaultButton(
                    height: screenHeight(context) * 0.06,
                    text: 'Complain',
                    onPressed: () {
                      setState(() {
                        displayComplainTextField = !displayComplainTextField;
                      });
                    },
                    foregroundColor: Theme.of(context).primaryColor,
                    radius: 10,
                    hasBorder: true,
                  ),
                )
              ],
            ),
    );
  }

  Widget _textField() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Write Your Complain',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset('assets/images/send_icon.svg'),
        ),
      ],
    );
  }
}
