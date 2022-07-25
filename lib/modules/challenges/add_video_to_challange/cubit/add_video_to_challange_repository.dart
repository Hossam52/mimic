import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';
import 'package:mimic/shared/services/upload_file.dart';

class ManageVideosChallangersRepository {
  Future<Response> uploadVideoToChallange(
      {required List<File> video,
      required File file,
      required int challangeId,
      required String challangeName,
      required String videoName,
      required Function onProgressUpload,
      }) async {
    List<MultipartFile> videoFiles = [];
    for (int index = 0; index < video.length; index++) {
      videoFiles.add(await uploadFile(video[index]));
    }

    FormData formData = FormData.fromMap({
      'thumb': await uploadFile(file),
      'videos[]': videoFiles,
      'video_name': videoName,
      'title': challangeName,
      'challenge_id': challangeId,
    });
    return await HandlingApis.postData(
      url: ConstantHelper.addVideoToChallange,
      data: formData,
      onSendProgress: onProgressUpload,
    );
  }
}
