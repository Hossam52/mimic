import 'package:flutter/material.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class GalleryIcon extends StatelessWidget {
  const GalleryIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      MimicIcons.folder,
      size: 40,
      color: Theme.of(context).primaryColor,
    );
  }
}
