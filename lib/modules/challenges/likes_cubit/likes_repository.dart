import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class LikesRepository {
  Future<Response> toggleLikeVideo(int videoId,) async 
  {
    return await HandlingApis.postData(url: ConstantHelper.toggleLike,
    data: {'video_id':videoId}
    );
  }
   Future<Response> toggleLikeComment(int videoId,) async 
  {
    return await HandlingApis.postData(url: ConstantHelper.toggleLike,
    data: {'comment_id':videoId}
    );
  }
   Future<Response> toggleLikeReplay(int videoId,) async 
  {
    return await HandlingApis.postData(url: ConstantHelper.toggleLike,
    data: {'replay_id':videoId}
    );
  }
}
