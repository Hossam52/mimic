import 'package:flutter/material.dart';
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
      this.prefixIcon})
      : super(key: key);
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? passwordWidget;
  final IconData? icon;
  final IconData? prefixIcon;
  final Color? iconColor;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          minLines: 1,
          textAlign: TextAlign.start,
          maxLines: maxLines,
          controller: controller,
          obscureText: isPassword,
          validator: validator,
          decoration: InputDecoration(
            iconColor: Theme.of(context).primaryColor,
            hintText: hintText,
            suffixIcon: Icon(
              icon,
              color: iconColor ?? ColorManager.grey,
            ),
            prefixIcon: prefixIcon == null
                ? null
                : Icon(
                    prefixIcon,
                    color: iconColor ?? ColorManager.grey,
                  ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: ColorManager.grey),
            ),
            label: _labelWidget(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _labelWidget() {
    return Text(hintText, style: getSemiBoldStyle());
  }
}
