import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimic/layout/search/search_challanges_cubit/search_challanges_cubit.dart';
import 'package:mimic/layout/search/search_users_cubit/search_users_cubit.dart';
import 'package:mimic/layout/widgets/tab_bar_header.dart';
import 'package:mimic/modules/search/search_challenges.dart';
import 'package:mimic/modules/search/search_people.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/cubits/categories_cubit/categories_cubit.dart';
import 'package:mimic/shared/helpers/helper_methods.dart';

final List<CustomTabBarItem> _searchTabs = [
  CustomTabBarItem(
      name: AppStrings.challenges, widget:  SearchChallenges()),
  CustomTabBarItem(name: AppStrings.people, widget: SearchPeople()),
];

class SearchLayout extends StatelessWidget {
  const SearchLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchUsersCubit(),
        ),
        BlocProvider(
          create: (context) => SearchChallangesCubit()..searchOnChallanges(),
        ),
        BlocProvider(create: (context)=>CategoriesCubit()..getAllCategories(),),
      ],
      child: GestureDetector(
        onTap: () => HelperMethods.closeKeyboard(context),
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
      ),
    );
  }
}
