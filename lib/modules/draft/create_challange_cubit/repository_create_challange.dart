import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';
import 'package:mimic/shared/services/upload_file.dart';

class CreateChallangeRepository {
  Future<Response> createChallange({
    required String challangeTitle,
    required String challangeDescription,
    required int categoryId,
    required String endDate,
    required List<File> videoData,
    required File thumbNail,
    required List<String> hashTag,
    required List<String> newHashTags,
    required String videoName,
    required Function onProgress,
  }) async {
    // log(newHashTags.toString());
    // log(hashTag.toString());

    List<MultipartFile> files = [];
    MultipartFile thumbFile = await uploadFile(thumbNail);
    for (var element in videoData) {
      files.add(await uploadFile(element));
    }

    FormData formData = FormData.fromMap({
      'title': challangeTitle,
      'description': challangeDescription,
      'category_id': categoryId,
      'end_date': endDate,
      'videos[]': files,
      'hashtags[]': hashTag,
      'hashtagNames[]': newHashTags,
      'video_name': videoName,
      'thumb': thumbFile,
    });
    return await HandlingApis.postData(
      url: ConstantHelper.createChallange,
      data: formData,
      onSendProgress: onProgress,
    );
  }
}
