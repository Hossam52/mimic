import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({Key? key, required this.imagePath, this.size = 40})
      : super(key: key);
  final String imagePath;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Image.asset(
        imagePath,
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}
