import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class RepliesRepository {
  Future<Response> getAllReplies
  ({required int commentId, int page = 1}) async 
  {
    return await HandlingApis.postData(
        url: ConstantHelper.getAllReplaiesByCommentId,
        data: {'comment_id': commentId},
        quary: {'page': page});
  }

  Future<Response> storeNewReplay(
      {required int commentId, required String body,required List<String> idsMention}) async {
    FormData formData = FormData.fromMap(
    {
      'mentions[]': idsMention,
      'comment_id': commentId,
      'body': body,
    });
    return await HandlingApis.postData(
        url: ConstantHelper.storeReplay, data: formData);
  }

 
  Future<Response>deleteReply({required int replayId})async
  {
    return await HandlingApis.postData(url: ConstantHelper.deleteReplay,
    data: 
    {
      'replay_id':replayId,
    }
    );
  }
}
