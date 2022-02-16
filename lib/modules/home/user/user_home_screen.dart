import 'package:flutter/material.dart';
import 'package:mimic/modules/home/widgets/challenge_item.dart';
import 'package:mimic/modules/home/widgets/header_name.dart';
import 'package:mimic/modules/home/widgets/highlight_item.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/shared/methods.dart';

class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight(context) * 0.26,
              child: const _Highlights(),
            ),
            const SizedBox(height: 8),
            const _CurrentChallenges(),
          ],
        ),
      ),
    );
  }
}

class _Highlights extends StatelessWidget {
  const _Highlights({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderName('Highlights'),
        const SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 15,
              childAspectRatio: 4 / 3,
            ),
            itemBuilder: (_, index) {
              return const HighlightItem();
            },
            itemCount: 5,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }
}

class _CurrentChallenges extends StatefulWidget {
  const _CurrentChallenges({Key? key}) : super(key: key);

  @override
  State<_CurrentChallenges> createState() => _CurrentChallengesState();
}

class _CurrentChallengesState extends State<_CurrentChallenges> {
  _HeaderEnum selectedHeader = _HeaderEnum.currentChallenges;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeaderName(
            'Current Challenges',
            selected: selectedHeader == _HeaderEnum.currentChallenges,
            onTap: () {
              setState(() {
                selectedHeader = _HeaderEnum.currentChallenges;
              });
            },
          ),
          HeaderName(
            'Marked',
            selected: selectedHeader == _HeaderEnum.marked,
            onTap: () {
              setState(() {
                selectedHeader = _HeaderEnum.marked;
              });
            },
          ),
        ],
      ),
      ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: 14,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ChallenegItem(
                onJoinTapped: () {},
                onChallengeTapped: () {
                  navigateTo(context, Routes.challengeDetails);
                },
              ),
            );
          })
    ]);
  }
}

enum _HeaderEnum { currentChallenges, marked }
