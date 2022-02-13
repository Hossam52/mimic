import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_circular_progress.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.backgroundColor = Colors.white,
      this.radius = 0,
      this.loading = false})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double radius;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: loading
          ? const DefaultCircularProgress()
          : Center(
              child: Text(text),
            ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(0.0)),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        shape: getMaterialStateProperty(
          RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
        ),
        foregroundColor: getMaterialStateProperty(Colors.black),
        textStyle: MaterialStateProperty.all(
          getBoldStyle(fontSize: FontSize.s14, color: Colors.black),
        ),
      ),
    );
  }
}
