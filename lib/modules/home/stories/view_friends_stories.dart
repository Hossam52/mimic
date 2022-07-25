import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';
import 'package:mimic/modules/home/stories/manage_stories_cubit/manage_stories_cubit.dart';
import 'package:mimic/modules/home/stories/models/stories_model.dart';
import 'package:mimic/modules/home/stories/models/story.dart';
import 'package:mimic/shared/video_players_widgets/my_story_player.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/cubits/helper_cubit/helper_cubit.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';

import '../../../shared/video_players_widgets/friend_story_view.dart';

class ViewFriendsStoriesScreen extends StatefulWidget {
  const ViewFriendsStoriesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewFriendsStoriesScreen> createState() =>
      _ViewFriendsStoriesScreenState();
}

class _ViewFriendsStoriesScreenState extends State<ViewFriendsStoriesScreen> {
  late ManageStoriesCubit manageStoriesCubit;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> storiesData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    FriendsStories friendsStories = storiesData['friends'];
    int selectedIndex = storiesData['index'];
    PageController _pageController = PageController(initialPage: selectedIndex);
    // if (!friendsStories.data[_pageController.page!.toInt()].authView) {
    //     manageStoriesCubit
    //         .viewStory(friendsStories.data[_pageController.page!.toInt()].id);
    //   }
    // _pageController.addListener(() {
    //   log('Enter Listner');
    //   if (!friendsStories.data[_pageController.page!.toInt()].authView) {
    //     manageStoriesCubit
    //         .viewStory(friendsStories.data[_pageController.page!.toInt()].id);
    //   }
    // });
    //log(storiesModel.myStories.first.toString());
    //    .map((e) => StoryItem(StoryPlay(story: e), duration: const Duration(seconds: 10))
    //PageController()
    return BlocProvider(
      create: (context) => ManageStoriesCubit(),
      lazy: false,
      child: Scaffold(
          backgroundColor: ColorManager.black,
          floatingActionButton: SizedBox(
            height: 50.h,
            width: 50.w,
            child: BlocConsumer<ManageStoriesCubit, ManageStoriesState>(
              listener: (_, state) {
                if (state is ManageStoriesViewSucccess) {
                  friendsStories.data[_pageController.page!.toInt()].authView =
                      true;
                }
              },
              builder: (context, state) {
                manageStoriesCubit = ManageStoriesCubit.get(context);
                return LikeButton(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  size: AppSize.largeIconSize,
                  bubblesColor: BubblesColor(
                      dotPrimaryColor: ColorManager.primary,
                      dotSecondaryColor: ColorManager.primaryOpacity60),

                  likeCountPadding: EdgeInsets.zero,

                  onTap: (_) async {
                    manageStoriesCubit.reactOnStory(
                      friendsStories.data[_pageController.page!.toInt()].id,
                    );
                    log('message');
                    return true;
                  },
                  padding: EdgeInsets.zero,
                  likeBuilder: (_) => Icon(
                    Icons.favorite_rounded,
                    size: 40.sp,
                    color: ColorManager.primary,
                  ),
                  // onTap: (_) async {
                  //   return true;
                  // },
                );
              },
            ),
          ),
          body: SafeArea(
            child: BlocProvider(
              create: (context) => HelperCubit(),
              lazy: false,
              child: SizedBox(
                height: 1.sh,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: friendsStories.data.length,
                  itemBuilder: (context, index) => Stack(
                    children: [
                      VideoPlayerStoryFriend(
                        story: friendsStories.data[index],
                        pageController: _pageController,
                        length: friendsStories.data.length - 1,
                        manageStoriesCubit: manageStoriesCubit,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

class StoryFriendView extends StatelessWidget {
  const StoryFriendView({Key? key, required this.story}) : super(key: key);
  final Story story;

  @override
  Widget build(BuildContext context) {
    return Stack(
      //alignment: AlignmentDirectional.topStart,
      children: [
        Container(
            height: 1.sh,
            color: ColorManager.black,
            child: VideoPlayerStory(
              story: story,
            )),
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
            top: 5.h,
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
                cachedNetworkImageProvider(story.user.image, 22.r),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  story.user.name,
                  style: getMediumStyle(color: ColorManager.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
