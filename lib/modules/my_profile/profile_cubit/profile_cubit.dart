import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/models/user_model/user_model.dart';
import 'package:mimic/models/video_models/videos_model.dart';
import 'package:mimic/modules/my_profile/profile_cubit/profile_repository.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/values_manager.dart';
import 'package:mimic/shared/helpers/error_handling/error_handler.dart';
import 'package:mimic/shared/helpers/error_handling/failure_model.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';
import 'package:mimic/shared/network/locale/cache_helper.dart';
import 'package:mimic/shared/services/upload_file.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileGetAllDataLoading());
  static ProfileCubit get(context) => BlocProvider.of(context);
  final ProfileRepository _profileRepository = ProfileRepository();
  final ErrorHandler _errorHandler = ErrorHandler();
  late UserModel userModel;
  late VideosModel videosModel;
  late ChallengesModel challengesModel;
  late Failure _failure;
  Future<void> getProfileAllData() async {
    emit(ProfileGetAllDataLoading());
    try {
      if (await checkInternetConnecation()) {
        final responses = await Future.wait([
          _profileRepository.getProfileData(),
          _profileRepository.getMyVideosData(),
          _profileRepository.getMyChallengs(),
        ]);
        userModel = UserModel.fromJson(responses[0].data);
        //log(responses[1].data.toString());
        videosModel = VideosModel.fromJson(responses[1].data);
        challengesModel =responses[2].data==null?ChallengesModel.fromJson({}) :ChallengesModel.fromJson(responses[2].data);
        emit(ProfileGetAllDataSuccess());
      } else {
        emit(ProfileGetAllDataNetworkDisable(AppStrings.checkInternet));
      }
    } catch (e) {
      log(e.toString());
      _failure = _errorHandler.getErrorHappen(e);
      emit(ProfileGetAllDataError(_failure.message));
      rethrow;
    }
  }

  Future<void> getMoreMyVideos({int page = 1}) async {
    try {
      final response = await _profileRepository.getMyVideosData(page: page);
      VideosModel _videosModel = VideosModel.fromJson(response.data);
      videosModel.videos.videos.addAll(_videosModel.videos.videos);
      videosModel.videos.links = _videosModel.videos.links;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editProfile({
    required String birthData,
    required int cityId,
    required int countryId,
    required String username,
    required String email,
    File? imageFile,
  }) async {
    emit(ProfileEditLoading());
    try {
      if (await checkInternetConnecation()) {
        MultipartFile? image =
            imageFile == null ? null : await uploadFile(imageFile);
        final response = await _profileRepository.updateProfile(
            birthData: birthData,
            cityId: cityId,
            countryId: countryId,
            username: username,
            email: email,
            image: image);

        log(response.data.toString());
        if (response.data['status']) {
          emit(ProfileEditSuccess());
          userModel = UserModel.fromJson(response.data);
          log(userModel.user.image);
          CacheHelper.saveDate(
              key: ValuesManager.imageKey, value: userModel.user.image);
          ValuesManager.imageUrl = userModel.user.image;
        } else {
          emit(ProfileEditError(Failure(
                  code: response.statusCode ?? 404,
                  message: response.statusMessage ?? '')
              .message));
        }
      } else {
        emit(ProfileEditError(AppStrings.checkInternet));
      }
    } catch (e) {
      emit(ProfileEditError(_errorHandler.getErrorHappen(e).message));
      rethrow;
    }
  }
}
