import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/modules/home/widgets/challenge_item.dart';
import 'package:mimic/layout/guest/widgets/guest_drawer.dart';
import 'package:mimic/layout/user/widgets/user_drawer.dart';
import 'package:mimic/modules/home/widgets/header_name.dart';
import 'package:mimic/modules/home/widgets/highlight_item.dart';
import 'package:mimic/modules/home/widgets/person_details.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/mimic_logo.dart';

class GuestHomeScreen extends StatelessWidget {
  GuestHomeScreen({Key? key}) : super(key: key);
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
            'Top',
            selected: selectedHeader == _HeaderEnum.top,
            onTap: () {
              setState(() {
                selectedHeader = _HeaderEnum.top;
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
                onJoinTapped: () {
                  navigateTo(context, Routes.errorGuestPermissions);
                },
              ),
            );
          })
    ]);
  }
}

enum _HeaderEnum { currentChallenges, top }
