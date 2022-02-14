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
      this.icon})
      : super(key: key);
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? passwordWidget;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          validator: validator,
          decoration: InputDecoration(
            iconColor: Theme.of(context).primaryColor,
            hintText: hintText,
            suffixIcon: Icon(
              icon,
              color: ColorManager.grey,
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
