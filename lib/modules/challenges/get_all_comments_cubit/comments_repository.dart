import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class CommentsRepository {
  Future<Response> getAllComments({required int videoId, int page = 1}) async {
    return await HandlingApis.postData(
        url: ConstantHelper.getAllCommnetsByVideoId,
        data: {'video_id': videoId},
        quary: {'page': page});
  }

  Future<Response> storeNewComment(
      {required int videoId, required String body}) async {
    FormData formData = FormData.fromMap({
      'mentions[]': [],
      'video_id': videoId,
      'body': body,
    });
    return await HandlingApis.postData(
        url: ConstantHelper.storeComment, data: formData);
  }

  Future<Response> updateComment({
    required int videoId,
    required String body,
    required int commentId,
  }) async {
    FormData formData = FormData.fromMap({
      'mentions[]': [],
      'video_id': videoId,
      'body': body,
      'comment_id':commentId,
    });
    return await HandlingApis.postData(
      url: ConstantHelper.updateComment,
      data: formData,
    );
  }
  Future<Response>deleteComment({required int commentId})async
  {
    return await HandlingApis.postData(url: ConstantHelper.deleteComment,
    data: {
      'comment_id':commentId,
    }
    );
  }
}
