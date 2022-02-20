import 'package:flutter/material.dart';
import 'package:mimic/modules/home/widgets/header_name.dart';
import 'package:mimic/modules/home/widgets/highlight_item.dart';
import 'package:mimic/shared/methods.dart';

class Highlights extends StatelessWidget {
  const Highlights({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderName(
            'Highlights',
            selected: true,
            displaySelectedIndicator: false,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 15,
                childAspectRatio: 7 / 6,
              ),
              itemBuilder: (_, index) {
                return const HighlightItem();
              },
              itemCount: 5,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
