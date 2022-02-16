import 'package:flutter/material.dart';
import 'package:mimic/shared/methods.dart';

class RoundedDrawerHeader extends StatelessWidget {
  const RoundedDrawerHeader({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      height: screenHeight(context) * 0.18,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(80),
        ),
      ),
      child: Padding(padding: const EdgeInsets.all(40.0), child: child),
    );
  }
}
