import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimic/layout/widgets/tab_bar_header.dart';
import 'package:mimic/modules/search/discover_cubit/discover_cubit.dart';
import 'package:mimic/modules/search/search_challenges.dart';
import 'package:mimic/modules/search/search_people.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

final List<CustomTabBarItem> _searchTabs = [
  CustomTabBarItem(
      name: AppStrings.challenges, widget: const SearchChallenges()),
  CustomTabBarItem(name: AppStrings.people, widget: SearchPeople()),
];

class SearchLayout extends StatelessWidget {
  const SearchLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscoverCubit(),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Expanded(
                child: TabBarHeader(
              tabBars: _searchTabs,
            )),
            Expanded(
              flex: 10,
              child: TabBarView(
                children:
                    _searchTabs.map((e) => Center(child: e.widget)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
