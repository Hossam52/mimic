
import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class ProfileRepository {
  Future<Response> getProfileData() async {
    try {
      final response =
          await HandlingApis.getData(url: ConstantHelper.getProfileUrl);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getMyVideosData({int page=1}) async {
    final response =
        await HandlingApis.postData(url: ConstantHelper.myVideosUrl,quary: {'page':page});
    return response;
  }

  Future<Response> getMyChallengs({int page=1}) async {
    final response =
        await HandlingApis.postData(url: ConstantHelper.getMyChallenges,
        quary: {'page':page});
    return response;
  }

  Future<Response> updateProfile({
    required String birthData,
    required int cityId,
    required int countryId,
    required String username,
    required String email,
    MultipartFile? image,
  }) async {
    final response = await HandlingApis.postData(
        url: ConstantHelper.editProfileUrl,
        data: FormData.fromMap({
          'user_name': username,
          'email': email,
          'country_id': countryId,
          'city_id': cityId,
          'image': image,
          'date_of_birth': birthData,
        }));
    return response;
  }
}
