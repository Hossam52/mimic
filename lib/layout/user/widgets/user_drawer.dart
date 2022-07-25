import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mimic/layout/user/cubit/user_cubit.dart';
import 'package:mimic/layout/user/widgets/user_custom_drawer_header.dart';
import 'package:mimic/layout/widgets/drawer_item.dart';
import 'package:mimic/modules/my_profile/profile_cubit/profile_cubit.dart';
import 'package:mimic/presentation/resourses/assets_manager.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:mimic/shared/cubits/language_cubit/languages_cubit.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/shared/methods.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return SafeArea(
          child: SizedBox(
            width: 260.w,
            child: Drawer(
              child: Column(
                children: [
                  const UserCustomDrawerHeader(),
                  SizedBox(height: 14.h),
                  Expanded(
                    flex: 6,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        for (int i = 0; i < _DrawerItemState.items.length; i++)
                          _drawerItem(_DrawerItemState.items[i], i),
                      ],
                    )),
                  ),
                  Divider(
                    color: ColorManager.darkGrey,
                    thickness: 1,
                    endIndent: 80.w,
                  ),
                  Expanded(
                    child: _drawerItem(
                        _DrawerItemState(
                            imagePath: ImageAssets.logout,
                            title: AppStrings.logout,
                            onPressed: (context) {
                              AuthCubit.get(context).logout();
                              navigateReplacement(context, Routes.login);
                            }),
                        0,
                        color: ColorManager.darkGrey),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _drawerItem(_DrawerItemState item, int index, {Color? color}) {
    if (item.subSections == null) {
      return DrawerItem(
          onTap: item.onPressed == null ? null : () => item.onPressed!(context),
          imagePath: item.imagePath,
          title: item.title.translateString(context),
          iconColor: color);
    }

    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: const EdgeInsets.all(0),
      expansionCallback: (_, val) {
        setState(() {
          _DrawerItemState.changeIsOpen(index);
        });
        item.onPressed!(context);
      },
      children: [
        ExpansionPanel(
          headerBuilder: (_, val) => DrawerItem(
              iconSize: item.iconSize,
              onTap: () {
                setState(() {
                  _DrawerItemState.changeIsOpen(index);
                });
                item.onPressed!(context);
              },
              imagePath: item.imagePath,
              title: item.title.translateString(context),
              iconColor: color),
          canTapOnHeader: item.subSections != null,
          isExpanded: item.isOpen,
          body: Column(
            children:
                item.subSections!.map((e) => _DrawerSection(item: e)).toList(),
          ),
        )
      ],
    );
  }

  Widget _titleBuilder(String text) {
    return Text(
      text,
      style: getSemiBoldStyle(fontSize: FontSize.s10),
    );
  }
}

class _DrawerSection extends StatelessWidget {
  const _DrawerSection({Key? key, required this.item}) : super(key: key);
  final _DrawerItemSubSection item;
  @override
  Widget build(BuildContext context) {
    return _SubSectionContainer(
      onTap: item.onTap == null
          ? null
          : () {
              item.onTap!(context);
            },
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SvgPicture.asset(item.imagePath,
                width: 15.w,
                height: 15.w,
                fit: BoxFit.fitHeight,
                color: item.iconColor),
          ),
          SizedBox(width: 10.w),
          Expanded(
              flex: 5,
              child: Text(item.title,
                  style: getRegularStyle(fontSize: FontSize.s10))),
          Expanded(
            child: item.count != null
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      item.count!,
                      style: getRegularStyle(
                          fontSize: FontSize.s9,
                          color: ColorManager.visibilityColor),
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}

class _SubSectionContainer extends StatelessWidget {
  const _SubSectionContainer(
      {Key? key, required this.onTap, required this.child})
      : super(key: key);
  final VoidCallback? onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 170.w,
          height: 30.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            color: ColorManager.drawerFillColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(4.0.r),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _DrawerItemState {
  // IconData icon;

  String title;
  String imagePath;
  List<_DrawerItemSubSection>? subSections;
  bool isOpen;
  void Function(BuildContext)? onPressed;
  final double? iconSize;
  _DrawerItemState({
    // required this.icon,
    required this.imagePath,
    required this.title,
    this.onPressed,
    this.isOpen = false,
    this.subSections,
    this.iconSize,
  });
  static List<_DrawerItemState> items = [
    _DrawerItemState(
        imagePath: ImageAssets.profile,
        title: AppStrings.profile,
        iconSize: 24.r,
        onPressed: (BuildContext context) {},
        subSections: [
          _DrawerItemSubSection(
              onTap: (context) {
                Navigator.pop(context);
                navigateTo(context, Routes.profileSettings);
              },
              imagePath: ImageAssets.editProfile,
              title: AppStrings.editmyProfile),
          _DrawerItemSubSection(
              onTap: (context) {
                Navigator.pop(context);

                UserCubit.instance(context)
                    .navigateToMyNewRequestChallenges(context);
              },
              imagePath: ImageAssets.myRequests,
              title: AppStrings.myRequests),
          _DrawerItemSubSection(
              onTap: (context) {
                Navigator.pop(context);

                navigateTo(context, Routes.allRanks);
              },
              imagePath: ImageAssets.myRank,
              title: AppStrings.myRank),
          _DrawerItemSubSection(
              onTap: (context) {
                Navigator.pop(context);
                UserCubit.instance(context)
                    .navigateToMyChallengesApproved(context);
              },
              imagePath: ImageAssets.myChallanges,
              title: AppStrings.myChallanges),
          _DrawerItemSubSection(
              onTap: (context) {
                Navigator.pop(context);

                UserCubit.instance(context).navigateToMyProfile(context);
              },
              imagePath: ImageAssets.myVideos,
              title: AppStrings.myVideos),
          _DrawerItemSubSection(
              onTap: (context) {
                Navigator.pop(context);

                navigateTo(context, Routes.notifications);
              },
              imagePath: ImageAssets.myNotifications,
              title: AppStrings.myNotification),
        ]),
    _DrawerItemState(
        imagePath: ImageAssets.discover,
        onPressed: (BuildContext context) {
          //discover
        },
        title: AppStrings.discoverChallanges,
        subSections: [
          _DrawerItemSubSection(
              onTap: (context) {
                Navigator.pop(context);
                UserCubit.instance(context).navigateToSearch(context);
              },
              imagePath: ImageAssets.soccer,
              title: AppStrings.soccer,
              count: '+3'),
          _DrawerItemSubSection(
              onTap: (context) {
                Navigator.pop(context);

                UserCubit.instance(context).navigateToSearch(context);
              },
              imagePath: ImageAssets.basketball,
              title: AppStrings.basketBalls,
              count: '+3'),
        ]),
    _DrawerItemState(
        imagePath: ImageAssets.myRank,
        title: AppStrings.marked,
        onPressed: (BuildContext context) {
          Navigator.pop(context);
          navigateTo(context, Routes.markedChallenges);
        }),
    _DrawerItemState(
      imagePath: ImageAssets.help,
      onPressed: (BuildContext context) {
        Navigator.pop(context);

        navigateTo(context, Routes.howToChallenge);
      },
      title: AppStrings.howToChallange,
    ),
    _DrawerItemState(
      imagePath: ImageAssets.customerServieces,
      onPressed: (BuildContext context) {
        Navigator.pop(context);

        navigateTo(context, Routes.customerSupport);
      },
      title: AppStrings.support,
    ),
    _DrawerItemState(
      imagePath: ImageAssets.ourPartner,
      onPressed: (BuildContext context) {},
      title: AppStrings.ourPartners,
    ),
    _DrawerItemState(
        imagePath: ImageAssets.language,
        onPressed: (BuildContext context) {},
        title: AppStrings.language,
        subSections: [
          _DrawerItemSubSection(
            imagePath: ImageAssets.done,
            onTap: (context) {
              LanguagesCubit.get(context).changeLanguage('ar');
            },
            title: AppStrings.arabic,
            iconColor: ColorManager.black,
          ),
          _DrawerItemSubSection(
              imagePath: ImageAssets.done,
              title: AppStrings.english,
              onTap: (context) {
                LanguagesCubit.get(context).changeLanguage('en');
              },
              iconColor: Colors.transparent),
        ])
  ];
  static void changeIsOpen(int index) {
    items[index].isOpen = !items[index].isOpen;
  }
}

class _DrawerItemSubSection {
  String title;
  String imagePath;
  void Function(BuildContext)? onTap;
  String? count;
  Color? iconColor;
  _DrawerItemSubSection({
    required this.title,
    required this.imagePath,
    this.onTap,
    this.count,
    this.iconColor,
  });
}
