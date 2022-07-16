import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';
import 'package:mimic/shared/services/upload_file.dart';

class StoryRepository {
  Future<Response> uploadStory(
      {required List<File> video,
      required File file,
      required String videoName}) async {
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
    );
  }

  Future<Response> getAllStories() async 
  {
    return await HandlingApis.getData(url: ConstantHelper.getAllStories);
  }
}
