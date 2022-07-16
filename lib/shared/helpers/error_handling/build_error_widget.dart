import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class BuildErrorWidget extends StatelessWidget {
  final String error;
  // ignore: use_key_in_widget_constructors
  const BuildErrorWidget(this.error);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error,
        style: getSemiBoldStyle(),
      ),
    );
  }
}
