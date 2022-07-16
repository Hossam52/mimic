import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField(
      {Key? key,
      required this.hintText,
      this.isPassword = false,
      required this.controller,
      this.validator,
      this.passwordWidget,
      this.icon,
      this.iconColor,
      this.maxLines = 1,
      this.prefixIcon,
      this.marginAfterEnd,
      this.labelText,
      this.enabled = true,
      this.borderRadius,
      this.action = TextInputAction.next,
      this.onTap,
      this.suffix,
      this.prefix,
      this.node,
      this.fillColor})
      : super(key: key);
  final String hintText;
  final bool isPassword;
  final TextInputAction action;
  final TextEditingController controller;
  final FocusNode? node;
  final String? Function(String?)? validator;
  final Widget? passwordWidget;
  final IconData? icon;
  final IconData? prefixIcon;
  final Widget? prefix;
  final Color? iconColor;
  final int maxLines;
  final double? marginAfterEnd;
  final String? labelText;
  final bool enabled;
  final double? borderRadius;
  final Widget? suffix;
  final Color? fillColor;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
      borderSide: BorderSide(color: ColorManager.grey),
    );
    return Column(
      children: [
        TextFormField(
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
          },
          enabled: enabled,
          minLines: 1,
          focusNode: node,
          textInputAction: action,
          textAlign: TextAlign.start,
          maxLines: maxLines,
          controller: controller,
          obscureText: isPassword,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ?? ColorManager.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
            iconColor: Theme.of(context).primaryColor,
            hintText: hintText,
            suffixIcon: suffix != null
                ? suffix
                : icon == null
                    ? null
                    : Icon(
                        icon,
                        color: iconColor ?? ColorManager.grey,
                      ),
            prefixIcon: prefix != null
                ? prefix
                : prefixIcon == null
                    ? null
                    : Icon(
                        prefixIcon,
                        size: 15,
                        color: iconColor ?? ColorManager.grey,
                      ),
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            disabledBorder: border,
            errorBorder: border,
            label: _labelWidget(),
          ),
        ),
        SizedBox(
          height: marginAfterEnd ?? 20.h,
        ),
      ],
    );
  }

  Widget _labelWidget() {
    return Text(labelText ?? hintText, style: getSemiBoldStyle());
  }
}
