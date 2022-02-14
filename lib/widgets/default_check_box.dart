import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class DefaultCheckbox extends StatelessWidget {
  const DefaultCheckbox(
      {Key? key, required this.val, this.onChange, required this.text})
      : super(key: key);
  final bool val;
  final void Function(bool? val)? onChange;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChange != null) onChange!(!val);
      },
      child: Row(
        children: [
          Checkbox(
              value: val,
              activeColor: Theme.of(context).primaryColor,
              onChanged: onChange),
          Text(
            text,
            style: getSemiBoldStyle(
                color: Theme.of(context).primaryColor, fontSize: FontSize.s14),
          )
        ],
      ),
    );
  }
}
