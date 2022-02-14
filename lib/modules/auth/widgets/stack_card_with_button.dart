import 'package:flutter/material.dart';
import 'package:mimic/shared/methods.dart';

class StackCardInButton extends StatelessWidget {
  const StackCardInButton(
      {Key? key,
      required this.header,
      required this.content,
      required this.button,
      this.height})
      : super(key: key);
  final Widget header;
  final Widget content;
  final Widget button;
  final double? height;
  @override
  Widget build(BuildContext context) {
    final buttonHeight = height ?? screenHeight(context) * 0.07;
    final halfButtonHeight = buttonHeight / 2;
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 10,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      header,
                      const SizedBox(height: 20),
                      content,
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: halfButtonHeight),
            ],
          ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SizedBox(
                  height: buttonHeight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context) * 0.27),
                    child: button,
                  )))
        ],
      ),
    );
  }
}
