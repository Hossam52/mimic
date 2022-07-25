import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/models/enums/challengesUser.dart';
import 'package:mimic/models/user_model/user.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/presentation/resourses/assets_manager.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';
import 'package:mimic/widgets/default_appbar.dart';
import 'package:mimic/widgets/hashtag_item.dart';
import 'package:mimic/widgets/loading_brogress.dart';
import 'package:mimic/widgets/play_video_icon.dart';
import 'package:mimic/widgets/profile_statistics.dart';
import 'package:mimic/widgets/video_statistic_item.dart';

import 'cubit/challanger_profile_cubit.dart';
import 'joined_and_created_row_buttons.dart';

class ChallengerProfile extends StatelessWidget {
  ChallengerProfile({Key? key}) : super(key: key);
  final ScrollController createdController = ScrollController();
  final ScrollController joinedController = ScrollController();
  late ChallangerProfileCubit _challangerProfileCubit;
  @override
  Widget build(BuildContext context) {
    dynamic challangerId = ModalRoute.of(context)!.settings.arguments;

    createdController.addListener(() {
      if (createdController.position.maxScrollExtent ==
          createdController.offset) {
        if (_challangerProfileCubit.selectedFilter == 0) {
          _challangerProfileCubit.getMoreChallengesCreated();
        } else {
          _challangerProfileCubit.getMoreChallengesJoined();
        }
        log('message');
      }
    });
    return BlocProvider(
      create: (context) =>
          ChallangerProfileCubit()..getAllDataChallenger(challangerId),
      child: BlocBuilder<ChallangerProfileCubit, ChallangerProfileState>(
        builder: (context, state) {
          if (state is ChallangerProfileLoading && state.isFirst) {
            return Scaffold(
              appBar: defaultAppbar(
                title: AppStrings.profile.translateString(context),
              ),
              body: const LoadingProgress(),
            );
          } else if (state is ChallangerProfileError) {
            return Scaffold(
              appBar: defaultAppbar(
                title: AppStrings.profile.translateString(context),
              ),
              body: BuildErrorWidget(state.error),
            );
          } else {
            _challangerProfileCubit = ChallangerProfileCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  AppStrings.profile.translateString(context),
                  style: getBoldStyle(fontSize: FontSize.s14),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                leading: BackButton(color: ColorManager.commentsColor),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Dialogs.showQrSaveShare(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: SvgPicture.asset(ImageAssets.scanQr,
                          color: ColorManager.commentsColor,
                          width: 24.w,
                          height: 24.w),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: createdController,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 3.h),
                  child: Column(
                    children: [
                      _ProfileInfo(
                        challenger:
                            ChallangerProfileCubit.get(context).challenger.user,
                      ),
                      SizedBox(height: 25.h),
                      ProfileStatistics(
                          staticticsData: ChallangerProfileCubit.get(context)
                              .challenger
                              .staticticsData),
                      SizedBox(height: 32.h),
                      const _Rank(),
                      SizedBox(height: 40.h),
                      JoinedAndCreatedRowButtons(),
                      SizedBox(height: 24.h),
                      ChallangerProfileCubit.get(context).selectedFilter ==
                              ChallengesUserEnum.created.index
                          ? ChallangerProfileCubit.get(context)
                                  .challengesCreatedByUser
                                  .isEmpty
                              ? BuildErrorWidget(AppStrings
                                      .noChallengesCreatedBy
                                      .translateString(context) +
                                  ' ' +
                                  ChallangerProfileCubit.get(context)
                                      .challenger
                                      .user
                                      .name)
                              : challengesUser(
                                  challenges:
                                      ChallangerProfileCubit.get(context)
                                          .challengesCreatedByUser,
                                  controller: createdController,
                                  context: context)
                          : ChallangerProfileCubit.get(context)
                                  .challengesJoinedByUser
                                  .isEmpty
                              ? BuildErrorWidget(AppStrings.noChallenges
                                      .translateString(context) +
                                  ChallangerProfileCubit.get(context)
                                      .challenger
                                      .user
                                      .name +
                                  ' ' +
                                  AppStrings.joinedToThem
                                      .translateString(context))
                              : challengesUser(
                                  challenges:
                                      ChallangerProfileCubit.get(context)
                                          .challengesJoinedByUser,
                                  controller: createdController,
                                  context: context,
                                ),
                      SizedBox(
                        height: 10.h,
                      ),
                      if (state is ChallangerProfileLoading)
                        const LoadingProgress(),
                      //     ChallengesUser(
                      // challenges: ChallangerProfileCubit.get(context)
                      //     .challengesCreatedByUser,),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

Widget challengesUser(
    {required ScrollController controller,
    required BuildContext context,
    required List<Challange> challenges}) {
  return ListView.separated(
    separatorBuilder: (_, index) => SizedBox(height: 16.h),
    shrinkWrap: true,
    primary: false,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (_, index) => InkWell(
        onTap: () => navigateTo(context, Routes.challengeDetails,
            arguments: challenges[index].id),
        child: _VideoOverview(challange: challenges[index])),
    itemCount: challenges.length,
  );
}

// class ChallengesUser extends StatelessWidget {
//   const ChallengesUser(
//       {Key? key, required this.challenges, required this.controller})
//       : super(key: key);
//   final List<Challange> challenges;
//   final ScrollController controller;
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       controller: controller,
//       separatorBuilder: (_, index) => SizedBox(height: 16.h),
//       shrinkWrap: true,
//       //primary: false,
//       itemBuilder: (_, index) => InkWell(
//           onTap: () => navigateTo(context, Routes.challengeDetails,
//               arguments: challenges[index].id),
//           child: _VideoOverview(challange: challenges[index])),
//       itemCount: challenges.length,
//     );
//   }
// }

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo({Key? key, required this.challenger}) : super(key: key);
  final User challenger;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        cachedNetworkImageProvider(challenger.image, 60.r),
        // RoundedImage(
        //   imagePath: ImageAssets.avater,
        //   size: 65.r,
        // ),
        SizedBox(width: 8.w),
        Column(
          children: [
            Text(
              challenger.name,
              style: getRegularStyle(
                      fontSize: FontSize.s14, color: ColorManager.profileName)
                  .copyWith(
                      fontFamily: FontConstants.gibsonFamily,
                      fontWeight: FontWeight.w500),
            ),
            Text(
              '${challenger.country}, ${challenger.city}',
              style: getRegularStyle(
                      fontSize: FontSize.s9,
                      color: ColorManager.profileLocation)
                  .copyWith(fontFamily: FontConstants.gibsonFamily),
            ),
          ],
        )
      ],
    );
  }
}

class _Rank extends StatelessWidget {
  const _Rank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.h),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.myRank.translateString(context),
                    style: getBoldStyle(fontSize: FontSize.s18)),
                Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Text('Rank 2',
                      style: getBoldStyle(fontSize: FontSize.s14)),
                ),
                SizedBox(height: 10.h),
                RatingBarIndicator(
                  itemBuilder: (_, index) {
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 22.r,
                    );
                  },
                  rating: 5,
                  itemCount: 5,
                  itemSize: 22.r,
                ),
              ],
            ),
            const Spacer(),
            SvgPicture.asset(
              ImageAssets.crown,
              width: 100.w,
              height: 100.w,
            )
          ],
        ),
      ),
    );
  }
}

class _VideoOverview extends StatelessWidget {
  const _VideoOverview(
      {Key? key,
      this.defaultIconColor,
      this.borderRadius,
      required this.challange})
      : super(key: key);
  final Color? defaultIconColor;
  final double? borderRadius;
  final Challange challange;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.h,
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius ?? 6.r)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                cachedNetworkImage(
                    imageUrl: challange.videoCreator.thumNailUrl,
                    height: double.infinity,
                    width: double.infinity),
                // Image.asset(
                //   getVideoImageRandom(),
                //   width: double.infinity,
                //   height: double.infinity,
                //   fit: BoxFit.fill,
                // ),
                const BlackOpacity(
                  opacity: 0.37,
                ),
                PlayVideoIcon(size: 66.r),
                // const Align(
                //     alignment: Alignment.topLeft, child: PersonDetails()),
                // Padding(
                //   padding: EdgeInsets.all(8.w),
                //   child: Align(
                //       alignment: Alignment.bottomRight,
                //       child: Icon(
                //         Icons.volume_mute,
                //         color: ColorManager.white,
                //         size: 30.r,
                //       )),
                // ),
                Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: HashtagItem(title: challange.category),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              _challengeActions(context),
              const Spacer(),
              Icon(
                Icons.more_vert,
                size: 20.r,
                color: ColorManager.grey,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _challengeActions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.h),
      child: Wrap(
        spacing: 10.w,
        children: [
          FavoriteIcon(
            count: challange.likesNumber.toString(),
            textColor: ColorManager.black,
          ),
          CommentIcon(
            count: challange.commentsNumber.toString(),
            textColor: ColorManager.black,
            // onPressed: () {
            //  Dialogs.showCommentsDialog(context, 3);
            // },
          ),
          ViewIcon(
            count: challange.views.toString(),
            textColor: ColorManager.black,
            iconColor: ColorManager.commentsColor,
          ),
        ],
      ),
    );
  }
}
