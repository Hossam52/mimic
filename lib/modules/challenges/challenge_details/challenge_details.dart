import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/challenges/add_video_to_challange/cubit/add_video_to_challange_cubit.dart';
import 'package:mimic/modules/challenges/challange_data_cubit/challange_data_cubit.dart';
import 'package:mimic/modules/challenges/challenge_details/challangers_data.dart';
import 'package:mimic/modules/challenges/challenge_details/people_joined.dart';
import 'package:mimic/modules/challenges/challenge_details/statictics_and_join_button.dart';
import 'package:mimic/modules/challenges/get_all_comments_cubit/get_all_comments_cubit.dart';
import 'package:mimic/modules/challenges/likes_cubit/likes_cubit.dart';
import 'package:mimic/modules/challenges/watch_video_challanger_cubit/watch_video_challanger_cubit.dart';
import 'package:mimic/modules/challenges/widgets/challenge_title_and_discription.dart';
import 'package:mimic/modules/challenges/widgets/challenges_grid_view.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/shared/video_players_widgets/video_player_only.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/shared/helpers/helper_methods.dart';
import 'package:mimic/widgets/loading_brogress.dart';
import 'package:mimic/modules/home/widgets/header_name.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';

import 'hastags_widget.dart';

class ChallengeDetailsScreen extends StatelessWidget {
  ChallengeDetailsScreen({Key? key}) : super(key: key);
  final ScrollController getMoreVideosController = ScrollController();
  late ChallangeDataCubit cubit;
  @override
  Widget build(BuildContext context) {
    final String challangeId =
        ModalRoute.of(context)!.settings.arguments as String;
    // getMoreVideosController.addListener(() {
    //   if (getMoreVideosController.offset ==
    //       getMoreVideosController.position.maxScrollExtent) {
    //     if (cubit.videosModel != null &&
    //         cubit.videosModel.videos.links.next != null) {
    //       cubit.getMoreVideos();
    //     }
    //   }
    // });
    return WillPopScope(
      onWillPop: () async {
        HelperMethods.closeKeyboard(context);
        return true;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ChallangeDataCubit()
              ..getChallangData(
                challangeId: int.parse(challangeId),
              ),
          ),
          BlocProvider(
            create: (context) => ManageVideosChallangersCubit(),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => LikesCubit(),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => WatchVideoChallangerCubit(),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => GetAllCommentsCubit(),
            lazy: false,
          ),
          //   BlocProvider(
          //   create: (context) => WatchVideoChallangerCubit(),
          //   lazy: false,
          // ),
          // BlocProvider(
          //   create: (context) => LikesCubit(),
          //   lazy: false,
          // ),
        ],
        child: BlocBuilder<ChallangeDataCubit, ChallangeDataState>(
          builder: (context, state) {
            if (state is ChallangeDataError) {
              return Scaffold(body: BuildErrorWidget(state.error));
            } else if ((state is! ChallangeDataError &&
                    state is! ChallangeDataLoading &&
                    state is! ChallangeDataInitial) ||
                (state is ChallangeDataLoading && !state.isFirst)) {
              cubit = ChallangeDataCubit.get(context);
              return Scaffold(
                appBar: TransparentAppBar(
                    title: cubit.challangeDetails.challangeTitle),
                body: RefreshIndicator(
                  onRefresh: () async {
                    cubit.clear();
                    cubit.getChallangData(challangeId: int.parse(challangeId));
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: getMoreVideosController,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //          const _VideoPlayer(),
                          VideoPlayerOnly(
                              video: cubit.challangeDetails.videoCreator),
                          StatisticsAndJoinButton(),
                          //  _statisticsAndJoinButton(context, cubit),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ChallengeTitle(
                                  title: cubit.challangeDetails.challangeTitle),
                              IconButton(
                                  onPressed: () {
                                    cubit.toggleFavChallenge();
                                  },
                                  icon: Icon(
                                    Icons.bookmark_sharp,
                                    color: cubit.challangeDetails.authFavorite
                                        ? ColorManager.primary
                                        : ColorManager.black,
                                  ))
                            ],
                          ),
                          SizedBox(height: 5.h),
                          ChallengeDescription(
                              description: cubit.challangeDetails.description),
                          SizedBox(height: 4.h),
                          HashTagsWidget(
                              hashTags: cubit.challangeDetails.hashtags),
                          SizedBox(height: 13.h),
                          _remainingTime(context),
                          SizedBox(height: 15.h),
                          const PeopleJoined(),
                          SizedBox(height: 16.h),
                          _headerChallenges(),
                          const ChallangersData(),
                          //_challenges(context, cubit),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const Scaffold(body: LoadingProgress());
            }
          },
        ),
      ),
    );
  }

  Widget _remainingTime(context) {
    return Wrap(
      spacing: 10.w,
      children: [
        Text(
          '2 days, 10 hours, 12 min',
          style: getBoldStyle(
              color: Theme.of(context).primaryColor, fontSize: FontSize.s12),
        ),
        Text(
          'Remaining',
          style: getRegularStyle(fontSize: FontSize.s8),
        ),
      ],
    );
  }

  Widget _headerChallenges() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HeaderName(
          AppStrings.topChallangers,
          fontSize: FontSize.s14,
          displaySelectedIndicator: false,
          selected: true,
        ),
        // Padding(
        //   padding: EdgeInsets.only(right: 20.0.w),
        //   child: Text(
        //     'By date',
        //     style: getRegularStyle(),
        //   ),
        // )
      ],
    );
  }

  Widget _challenges(BuildContext context, ChallangeDataCubit cubit) {
    return Column(
      children: [
        ChallengesGridView(context: context),
        Padding(
          padding: EdgeInsets.all(8.0.r),
          child: TextButton(
            onPressed: () {
              navigateTo(context, Routes.allChallengers);
            },
            child: Text(
              'VIEW ALL >>',
              style: getRegularStyle(
                      fontSize: FontSize.s8,
                      color: ColorManager.visibilityColor)
                  .copyWith(decoration: TextDecoration.underline),
            ),
          ),
        ),
      ],
    );
  }
}

// class _VideoPlayer extends StatelessWidget {
//   const _VideoPlayer({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         navigateTo(context, Routes.challengerVideo);
//       },
//       child: Container(
//         clipBehavior: Clip.hardEdge,
//         height: screenHeight(context) * 0.43,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
//         child: Stack(
//           clipBehavior: Clip.hardEdge,
//           children: [
//             Image.asset(getVideoImageRandom(),
//                 width: double.infinity,
//                 height: double.infinity,
//                 fit: BoxFit.fill),
//             const BlackOpacity(opacity: 0.4),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 //   const Expanded(child: PersonDetails()),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ReportPopupMenuButton(
//                     iconColor: ColorManager.white,
//                   ),
//                 ),
//               ],
//             ),
//             Align(
//               alignment: Alignment.center,
//               child: Row(
//                 children: [
//                   const Spacer(),
//                   PlayVideoIcon(
//                     size: 44.r,
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Icon(
//                           Icons.skip_next,
//                           size: 30,
//                           color: ColorManager.white,
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
