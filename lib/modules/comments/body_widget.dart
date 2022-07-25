import 'package:flutter/material.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({Key? key, required this.body}) : super(key: key);
  final String body;
  @override
  Widget build(BuildContext context) {
    return LinkifyText(
      body,
      linkTypes: const [LinkType.userTag],
      textStyle: getRegularStyle(),
      linkStyle: getRegularStyle(color: Colors.blue),
      onTap: (client) {
        navigateTo(context, Routes.challengerProfile, arguments: client.value);
      },
    );
  }
}
