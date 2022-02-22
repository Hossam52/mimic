import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mimic/modules/auth/widgets/background_color_widget.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_logo.dart';

class AuthLayoutWidget extends StatelessWidget {
  const AuthLayoutWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundColorWidget(),
        _data(),
      ],
    );
  }

  Widget _data() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_logo(context), child],
          ),
        );
      }),
    );
  }

  Widget _logo(BuildContext context) {
    final bool canPop = Navigator.canPop(context);
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        MimicLogoVertical(
          height: screenHeight(context) * 0.24,
        ),
        if (canPop) const BackButton(),
      ],
    );
  }
}
