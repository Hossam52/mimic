import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mimic/layout/my_challenges/cubit/my_challenges_cubit.dart';
import 'package:mimic/layout/user/cubit/user_cubit.dart';
import 'package:mimic/layout/user/cubit/user_states.dart';
import 'package:mimic/layout/user/widgets/user_drawer.dart';
import 'package:mimic/layout/widgets/bottom_bar_widgets.dart';
import 'package:mimic/layout/widgets/mimic_bottom_bar.dart';
import 'package:mimic/layout/widgets/notification_icon.dart';
import 'package:mimic/modules/home/home_cubit/home_cubit_cubit.dart';
import 'package:mimic/modules/my_profile/profile_cubit/profile_cubit.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/mimic_logo.dart';

class UserMainLayout extends StatefulWidget {
  const UserMainLayout({Key? key}) : super(key: key);

  @override
  State<UserMainLayout> createState() => _UserMainLayoutState();
}

class _UserMainLayoutState extends State<UserMainLayout>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myChallengesController.dispose();
  }

  @override
  late TabController myChallengesController =
      TabController(length: 4, vsync: this);
  @override
  Widget build(BuildContext context) {
    ProfileCubit.get(context).getProfileAllData();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => HomeCubitCubit()..getHomeData(),
          lazy: false,
        ),
        // BlocProvider(
        //   create: (context) => ProfileCubit()..getProfileAllData(),
        // ),
        BlocProvider(
          create: (context) => MyChallengesCubit(
            tabBarController: myChallengesController,
          ),
        ),
      ],
      child: Builder(builder: (context) {
        final instance = UserCubit.instance(context);
        return WillPopScope(
          onWillPop: () async {
            if (instance.selectedScreenIndex == 0) {
              return true;
            } else {
              instance.changeScreenIndex(context, 0);
              return false;
            }
          },
          child: BlocBuilder<UserCubit, UserStates>(
            builder: (context, state) {
              return Scaffold(
                  resizeToAvoidBottomInset: false,
                  key: scaffoldKey,
                  appBar: AppBar(
                    centerTitle: true,
                    title:
                        MimicLogoHorizontal(width: screenWidth(context) * 0.25),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      onPressed: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                      icon: Icon(
                        MimicIcons.menu,
                        size: 18.r,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    actions: const [
                      NotificationIcon(),
                    ],
                  ),
                  drawer: const UserDrawer(),
                  body: Column(
                    children: [
                      Expanded(child: instance.screen),
                      MimicBottomBar(
                        selectedIndex: instance.selectedScreenIndex,
                        onTap: (index) {
                          instance.changeScreenIndex(context, index);
                        },
                        bottomBars: [
                          MimicBottomBarItem(
                              title: AppStrings.home,
                              widget: const HomeBottomBarWidget()),
                          MimicBottomBarItem(
                              title: AppStrings.discover,
                              widget: const SearchBottomBarWidget()),
                          MimicBottomBarItem(
                              title: '',
                              widget: const AddChallengeBottomBarWidget()),
                          MimicBottomBarItem(
                              title: AppStrings.challenges,
                              widget: const ChallengesBottomBarWidget()),
                          MimicBottomBarItem(
                              title: AppStrings.account,
                              widget: const AccountBottomBarWidget()),
                        ],
                      ),
                    ],
                  ));
            },
          ),
        );
      }),
    );
  }
}
