import 'package:flutter/material.dart';
import 'package:mimic/modules/challenges/widgets/challenges_grid_view.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';

class AllChallengers extends StatelessWidget {
  const AllChallengers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TransparentAppBar(title: 'All challenges'),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ChallengesGridView(
          showPlayIcon: false,
          itemCount: 16,
        ),
      ),
    );
  }
}
