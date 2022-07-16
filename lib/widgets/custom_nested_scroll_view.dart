import 'package:flutter/material.dart';

class CustomNestedScrollView extends StatelessWidget {
  const CustomNestedScrollView(
      {Key? key, required this.headerWidgets, required this.body})
      : super(key: key);
  final List<Widget> headerWidgets;
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) => headerWidgets
          .map(
            (e) => SliverToBoxAdapter(
              child: e,
            ),
          )
          .toList(),
      body: body,
    );
  }
}
