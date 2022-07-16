import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mimic/modules/home/stories/models/stories_model.dart';
import 'package:mimic/modules/home/stories/story_play.dart';
import 'package:mimic/modules/video_player_only.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import "package:story_view/story_view.dart";

class ViewMyStoriesScreen extends StatelessWidget {
  ViewMyStoriesScreen({Key? key}) : super(key: key);
  final controller = StoryController();

  // List<StoryItem> storyItems = [
  //   StoryItem.text(title: 'title', backgroundColor: ColorManager.primary),
  //   StoryItem.text(
  //       title: 'Text',
  //       backgroundColor: ColorManager.primary,
  //       duration: Duration(seconds: 10)),
  // ]; //
  @override
  Widget build(BuildContext context) {
    StoriesModel? storiesModel =
        ModalRoute.of(context)!.settings.arguments as StoriesModel;

    List<StoryItem> storyItems = storiesModel.myStories
        .map((e) =>
            StoryItem(StoryPlay(story: e), duration: Duration(seconds: 10)))
        .toList();

    //    .map((e) => StoryItem(StoryPlay(story: e), duration: const Duration(seconds: 10))

    return StoryView(
      storyItems: storyItems,
      controller: controller,
      
    );
  }
}
