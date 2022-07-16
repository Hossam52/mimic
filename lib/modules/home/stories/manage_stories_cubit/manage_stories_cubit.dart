import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ffmpeg/statistics.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/video_models/video_info_model.dart';
import 'package:mimic/modules/home/stories/manage_stories_cubit/story_repository.dart';
import 'package:mimic/modules/home/stories/models/stories_model.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/helpers/error_handling/failure_model.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';
import 'package:mimic/shared/services/video_services.dart';

part 'manage_stories_state.dart';

class ManageStoriesCubit extends Cubit<ManageStoriesState> {
  ManageStoriesCubit() : super(ManageStoriesInitial());
  static ManageStoriesCubit get(context) => BlocProvider.of(context);
  StoryRepository _storyRepository = StoryRepository();
  late StoriesModel _storiesModel;
  StoriesModel get getStories {
    return _storiesModel;
  }

  Future<void> createStory({
    File? videoFile,
  }) async {
    emit(ManageStoriesLoadingUploading());
    if (await checkInternetConnecation()) {
      try {
        //SecurityContext.alpnSupported
        final String randomVideoName =
            DateTime.now().millisecondsSinceEpoch.toString();
        // video preparing to upload
        double _progress = 0.0;

        VideoServices.enableStatisticsCallback(cb: (Statistics cb) {
          double partLoaded = double.parse((cb.time / 1000).toStringAsFixed(2));
          log(VideoServices.videoDuration.toString());
          _progress = double.parse((partLoaded / VideoServices.videoDuration)
              .toStringAsPrecision(2));
          if (_progress <= 0.95) {
            emit(ManageStoriesPrepareLoading(_progress));
          } else {
            emit(ManageStoriesLoadingUploading());
          }
        });

        VideoCompressed _videoCompressed =
            await VideoServices.processedVideo(videoFile!, randomVideoName);
        final response = await _storyRepository.uploadStory(
            video: _videoCompressed.videoFiles,
            file: _videoCompressed.thumbnail,
            videoName: randomVideoName);

        log(response.data.toString());
        if (response.data['status']) {
          emit(ManageStoriesSucceessUploading());
        } else {
          emit(
              ManageStoriesErrorUploading(response.data['message'].toString()));
        }
      } catch (e) {
        log(e.toString());
        emit(ManageStoriesErrorUploading(e.toString()));
        return;
      }
    } else {
      emit(ManageStoriesErrorUploading(AppStrings.checkInternet));
    }
  }

  Future<void> getAllStories() async {
    if (await checkInternetConnecation()) {
      emit(ManageStoriesLoadingData());
      try {
        final response = await _storyRepository.getAllStories();
        log('Stories');
        if (response.data['status']) {
          _storiesModel = StoriesModel.fromJson(response.data);
          emit(ManageStoriesSuccessData());
        } else {
          emit(ManageStoriesErrorData(response.data['message']));
        }
      } catch (e) {
        // emit(ManageStoriesErrorData(get));
        rethrow;
      }
    } else {
      emit(ManageStoriesErrorData(AppStrings.checkInternet));
      //  emit(state)
    }
  }
}
