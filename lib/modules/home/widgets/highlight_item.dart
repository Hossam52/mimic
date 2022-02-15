import 'package:flutter/material.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/modules/home/widgets/person_details.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';

class HighlightItem extends StatelessWidget {
  const HighlightItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      clipBehavior: Clip.hardEdge,
      children: [_image(), const BlackOpacity(), const PersonDetails()],
    );
  }

  Container _image() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorManager.black.withOpacity(0.5)),
      child: Image.asset(
        'assets/images/static/interest3.png',
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
