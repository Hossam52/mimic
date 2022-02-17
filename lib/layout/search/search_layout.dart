import 'package:flutter/material.dart';
import 'package:mimic/modules/search/search_challenges.dart';
import 'package:mimic/modules/search/search_people.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class SearchLayout extends StatelessWidget {
  const SearchLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Expanded(
            child: TabBar(
                labelStyle: getBoldStyle(),
                labelPadding: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                unselectedLabelStyle: getBoldStyle(),
                labelColor: ColorManager.black,
                tabs: const [
                  Text('Challenges'),
                  Text('People'),
                ],
                indicatorColor: ColorManager.tabBarIndicator),
          ),
          const Expanded(
            flex: 10,
            child: TabBarView(children: [
              Center(
                child: SearchChallenges(),
              ),
              Center(
                child: SearchPeople(),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
