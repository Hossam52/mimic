import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration.collapsed(hintText: '').copyWith(
        fillColor: ColorManager.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: DropdownButtonHideUnderline(child: child),
    );
  }
}
