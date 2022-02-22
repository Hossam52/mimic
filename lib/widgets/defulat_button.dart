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
      this.loading = false,
      this.opacity = 1,
      this.height,
      this.width,
      this.foregroundColor,
      this.trailing,
      this.disabledColor,
      this.hasBorder = true,
      this.padding,
      this.borderColor})
      : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final Color? disabledColor;
  final Color backgroundColor;
  final Color? foregroundColor;
  final double radius;
  final bool loading;
  final bool hasBorder;
  final double opacity;
  final double? height;
  final double? width;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final buttonHeight = height ?? screenHeight(context) * 0.06;
    final buttonWidth = width ?? double.infinity; //screenWidth(context) * 0.7;
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Container(
          padding: padding,
          child: loading
              ? const DefaultCircularProgress()
              : trailing == null
                  ? Text(text)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 2),
                        const Spacer(),
                        Center(
                          child: Text(text),
                        ),
                        const Spacer(flex: 2),
                        if (trailing != null) trailing!,
                        const Spacer(),
                      ],
                    ),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0.0)),
          backgroundColor: MaterialStateProperty.all(onPressed == null
              ? disabledColor ?? ColorManager.primaryOpacity60
              : backgroundColor.withOpacity(opacity)),
          shape: getMaterialStateProperty(
            RoundedRectangleBorder(
              side: !hasBorder
                  ? BorderSide.none
                  : BorderSide(
                      color: borderColor ?? Theme.of(context).primaryColor,
                      width: 1.2,
                    ),
              borderRadius: BorderRadius.all(
                Radius.circular(radius),
              ),
            ),
          ),
          foregroundColor:
              getMaterialStateProperty(foregroundColor ?? Colors.black),
          textStyle: MaterialStateProperty.all(
            getBoldStyle(
                fontSize: FontSize.s14, color: foregroundColor ?? Colors.black),
          ),
        ),
      ),
    );
  }
}
