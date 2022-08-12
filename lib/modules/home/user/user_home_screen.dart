import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/home/home_cubit/home_cubit_cubit.dart';
import 'package:mimic/modules/home/stories/manage_stories_cubit/manage_stories_cubit.dart';
import 'package:mimic/modules/home/widgets/challenge_item.dart';
import 'package:mimic/modules/home/widgets/header_name.dart';
import 'package:mimic/modules/home/widgets/highlights.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController challengesController = ScrollController();
  @override
  Widget build(BuildContext context) {
    challengesController.addListener(() {
      if (challengesController.position.maxScrollExtent ==
          challengesController.offset) {
        if (HomeCubitCubit.get(context).getChallengesNext) {
          HomeCubitCubit.get(context).getHomeData();
        }
      }
    });
    return RefreshIndicator(
      onRefresh: () async {
        HomeCubitCubit.get(context).getHomeData();
        HomeCubitCubit.get(context).clear();
        ManageStoriesCubit.get(context).getAllStories();
      },
      child: BlocBuilder<HomeCubitCubit, HomeCubitState>(
        builder: (context, state) {
          if (state is HomeCubitLoading && state.isFirst) {
            return const LoadingProgressSearchChallanges();
          } else if (state is HomeCubitError &&
              HomeCubitCubit.get(context).challanges.isEmpty) {
            return Center(
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: BuildErrorWidget(state.error)));
          } else {
            HomeCubitCubit homeCubitCubit = HomeCubitCubit.get(context);
            return SingleChildScrollView(
              controller: challengesController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                    start: AppPadding.p10.w, end: AppPadding.p10.w),
                child: Column(
                  children: [
                    BlocBuilder<ManageStoriesCubit, ManageStoriesState>(
                      builder: (context, state) {
                        if (state is ManageStoriesLoadingData) {
                          return const LoadingProgress();
                        } else if (state is ManageStoriesSuccessData ||
                            state is ManageStoriesSucceessUploading) {
                          return const Highlights();
                        } else {
                          return const BuildErrorWidget('error');
                        }
                      },
                    ),
                    SizedBox(height: AppPadding.p16.h),
                    _CurrentChallenges(homeCubitCubit: homeCubitCubit),
                    SizedBox(
                      height: 5.h,
                    ),
                    if (state is HomeCubitLoading) const LoadingProgress(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class _CurrentChallenges extends StatefulWidget {
  const _CurrentChallenges({Key? key, required this.homeCubitCubit})
      : super(key: key);
  final HomeCubitCubit homeCubitCubit;
  @override
  State<_CurrentChallenges> createState() => _CurrentChallengesState();
}

class _CurrentChallengesState extends State<_CurrentChallenges> {
  _HeaderEnum selectedHeader = _HeaderEnum.currentChallenges;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(right: AppPadding.p4.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderName(
              AppStrings.currentChallanges.translateString(context),
              fontSize: FontSize.s18,
              selected: selectedHeader == _HeaderEnum.currentChallenges,
              onTap: () {
                setState(() {
                  selectedHeader = _HeaderEnum.currentChallenges;
                });
              },
            ),
            // HeaderName(
            //   AppStrings.marked.translateString(context),
            //   fontSize: FontSize.s18,
            //   selected: selectedHeader == _HeaderEnum.marked,
            //   onTap: () {
            //     setState(() {
            //       selectedHeader = _HeaderEnum.marked;
            //     });
            //   },
            // ),
          ],
        ),
      ),
      SizedBox(height: AppSize.s18.h),
      widget.homeCubitCubit.challanges.isEmpty
          ? Center(
              child: Text(
              AppStrings.noAvailableChallanges,
              style: getSemiBoldStyle(),
              textAlign: TextAlign.center,
            ))
          : ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: widget.homeCubitCubit.challanges.length,
              itemBuilder: (_, index) {
                return ChallenegItem(
                  challange: widget.homeCubitCubit.challanges[index],
                  onJoinTapped: () {},
                  onChallengeTapped: () {
                    navigateTo(context, Routes.challengeDetails,
                        arguments: widget.homeCubitCubit.challanges[index].id);
                  },
                );
              })
    ]);
  }
}

enum _HeaderEnum { currentChallenges, marked }
