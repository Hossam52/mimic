import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';
import 'package:mimic/shared/services/upload_file.dart';

class StoryRepository {
  Future<Response> uploadStory({
    required List<File> video,
    required File file,
    required String videoName,
    required Function onSendProgress,
  }) async {
    List<MultipartFile> videoFiles = [];
    for (int index = 0; index < video.length; index++) {
      videoFiles.add(await uploadFile(video[index]));
    }

    FormData formData = FormData.fromMap({
      'thumb': await uploadFile(file),
      'videos[]': videoFiles,
      'video_name': videoName,
    });
    return await HandlingApis.postData(
      url: ConstantHelper.addStoryUrl,
      data: formData,
      onSendProgress: onSendProgress,
    );
  }

  Future<Response> getFriendsViewMyStory(int storyId) async 
  {
    return await HandlingApis.postData(url: ConstantHelper.getViewsMyStory,
    data: {'story_id':storyId});
  }

  Future<Response> getAllStories() async {
    return await HandlingApis.getData(url: ConstantHelper.getAllStories);
  }

  Future<Response> viewStoryFriend(int storyId) async {
    log('story_id $storyId');
    return await HandlingApis.postData(
        url: ConstantHelper.watchStoryFriend,
        data: {
          'story_id': storyId,
        });
  }

  Future<Response> reactStoryFriend(int storyId) async {
    return await HandlingApis.postData(url: ConstantHelper.reactStory, data: {
      'story_id': storyId,
    });
  }
}
