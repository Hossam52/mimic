import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/user_model/user_abstract_story_reacts_model.dart';
import 'package:mimic/modules/home/stories/manage_stories_cubit/manage_stories_cubit.dart';
import 'package:mimic/modules/home/stories/models/stories_model.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/shared/video_players_widgets/my_story_player.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values_manager.dart';
import 'package:mimic/shared/cubits/helper_cubit/helper_cubit.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class ViewMyStoriesScreen extends StatelessWidget {
  const ViewMyStoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StoriesModel storiesModel =
        ModalRoute.of(context)!.settings.arguments as StoriesModel;
    log('story id : ' + storiesModel.myStories.first.id.toString());
    //    .map((e) => StoryItem(StoryPlay(story: e), duration: const Duration(seconds: 10))

    return Scaffold(
        body: SafeArea(
      child: BlocProvider(
        create: (context) => HelperCubit(),
        lazy: false,
        child: SizedBox(
          height: 1.sh,
          child: Stack(
            //alignment: AlignmentDirectional.topStart,
            children: [
              Container(
                  height: 1.sh,
                  color: ColorManager.black,
                  child: VideoPlayerStory(story: storiesModel.myStories[0])),
              // Positioned(
              //   top: 0,
              //   child: Text(
              //     ValuesManager.username,
              //     style: getMediumStyle(color: ColorManager.white),
              //   ),
              // ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 5.w,
                  top: 15.h,
                ),
                child: SizedBox(
                  height: 40.h,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BackButton(
                        color: ColorManager.white,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      cachedNetworkImageProvider(ValuesManager.imageUrl, 22.r),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        ValuesManager.username,
                        style: getMediumStyle(color: ColorManager.white),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 60.h,
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  child: BlocProvider(
                    create: (context) => ManageStoriesCubit()
                      ..getStoryReacts(storiesModel.myStories[0].id),
                    child: BlocBuilder<ManageStoriesCubit, ManageStoriesState>(
                      builder: (context, state) {
                        return InkWell(
                            onTap: () async {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusDirectional.only(
                                      topEnd: Radius.circular(AppSize.s18.r),
                                      topStart: Radius.circular(AppSize.s18.r),
                                    ),
                                  ),
                                  builder: (context) {
                                    if (state
                                        is ManageStoriesViewMyStorySucccess) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: AppSize.s10.h,
                                            horizontal: AppSize.s10.w),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.visibility_sharp,
                                                  color: ColorManager.black,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(state.users.length
                                                    .toString()),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            ListView.separated(
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    ((context, index) =>
                                                        UserViewStoryItem(
                                                            user: state
                                                                .users[index])),
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                itemCount: state.users.length),
                                          ],
                                        ),
                                      );
                                    } else if (state
                                        is ManageStoriesViewMyStoryError) {
                                      return BuildErrorWidget(state.error);
                                    } else {
                                      return const LoadingProgressSearchChallanges();
                                    }
                                  });
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.visibility_sharp,
                                  color: ColorManager.white,
                                ),
                                // SizedBox(
                                //   height: 2.h,
                                // ),
                                // Text(
                                //   storiesModel.myStories.first.watchCount
                                //       .toString(),
                                //   style:
                                //       getMediumStyle(color: ColorManager.white),
                                // ),
                              ],
                            ));
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class UserViewStoryItem extends StatelessWidget {
  const UserViewStoryItem({Key? key, required this.user}) : super(key: key);
  final UserAbstracStoryReactstModel user;
  @override
  Widget build(BuildContext context) {
    log(user.countReacts.toString());
    return InkWell(
      onTap: () {
        navigateTo(context, Routes.challengerProfile, arguments: user.id);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          cachedNetworkImageProvider(user.image, 30.r),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: SizedBox(
              height: 20.h,
              child: user.countReacts! <= 5
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => Icon(
                        Icons.favorite,
                        color: ColorManager.primary,
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 3.w,
                      ),
                      itemCount: user.countReacts!,
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => Icon(
                              Icons.favorite,
                              color: ColorManager.primary,
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              width: 3.w,
                            ),
                            itemCount: user.countReacts!,
                          ),
                        ),
                        Text((user.countReacts! - 5).toString() + ' +'),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}
