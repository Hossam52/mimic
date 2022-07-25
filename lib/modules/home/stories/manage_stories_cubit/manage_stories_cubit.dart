import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ffmpeg/statistics.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/user_model/user_abstract_story_reacts_model.dart';
import 'package:mimic/models/video_models/video_info_model.dart';
import 'package:mimic/modules/home/stories/manage_stories_cubit/story_repository.dart';
import 'package:mimic/modules/home/stories/models/stories_model.dart';
import 'package:mimic/modules/home/stories/models/story.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';
import 'package:mimic/shared/services/video_services.dart';

part 'manage_stories_state.dart';

class ManageStoriesCubit extends Cubit<ManageStoriesState> {
  ManageStoriesCubit() : super(ManageStoriesInitial());
  static ManageStoriesCubit get(context) => BlocProvider.of(context);
  final StoryRepository _storyRepository = StoryRepository();
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
            videoName: randomVideoName,
            onSendProgress: (int send, int total) {
              emit(ManageStoriesLoadingProgressUploading((send / total)));
            });

        if (response.data['status']) {
          _storiesModel.myStories.add(Story.fromJson(response.data['SV']));
          log(response.data.toString());
          //_storiesModel.myStories.add();
          emit(ManageStoriesSucceessUploading());
        } else {
          emit(
              ManageStoriesErrorUploading(response.data['message'].toString()));
        }
      } catch (e) {
        log(e.toString());
        emit(ManageStoriesErrorUploading(e.toString()));
        rethrow;
      }
    } else {
      emit(ManageStoriesErrorUploading(AppStrings.checkInternet));
    }
  }

  Future<void> getStoryReacts(int storyId) async {
    if (await checkInternetConnecation()) {
      emit(ManageStoriesViewMyStoryLoading());
      try {
        final response = await _storyRepository.getFriendsViewMyStory(storyId);
        if (response.data['status']) {
          emit(ManageStoriesViewMyStorySucccess(
              List.from(response.data['stories'])
                  .map(
                    (e) => UserAbstracStoryReactstModel.fromJson(e),
                  )
                  .toList()));
        } else {
          emit(ManageStoriesViewMyStorySucccess(const []));
        }
      } catch (e) {
        emit(ManageStoriesViewMyStoryError(e.toString()));
        rethrow;
      }
    } else 
    {
        emit(ManageStoriesViewMyStoryError(AppStrings.checkInternet));

    }
  }

  Future<void> getAllStories() async {
    if (await checkInternetConnecation()) {
      emit(ManageStoriesLoadingData());
      try {
        final response = await _storyRepository.getAllStories();
        log('Stories');
        if (response.data['status']) {
          //  log(response.data.toString());
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

  Future<void> reactOnStory(int storyId) async {
    if (await checkInternetConnecation()) {
      emit(ManageStoriesReactLoading());
      try {
        final response = await _storyRepository.reactStoryFriend(storyId);
        log('react ${response.data.toString()}');
        if (response.data['status']) {
          emit(ManageStoriesReactSucccess());
        } else {
          emit(ManageStoriesReactError(response.data['message'] ?? ''));
        }
      } catch (e) {
        
        emit(ManageStoriesReactError(e.toString()));

        rethrow;
      }
    } else {
      emit(ManageStoriesReactError(AppStrings.checkInternet));
    }
  }

  //view story
  Future<void> viewStory(int storyId) async {
    if (await checkInternetConnecation()) {
      emit(ManageStoriesViewLoading());
      try {
        final response = await _storyRepository.viewStoryFriend(storyId);
        log(response.data.toString());
        if (response.data['status']) {
          emit(ManageStoriesViewSucccess());
        } else {
          emit(ManageStoriesViewError(response.data['message'] ?? ''));
        }
      } catch (e) {
        emit(ManageStoriesViewError(e.toString()));

        rethrow;
      }
    } else {
      emit(ManageStoriesViewError(AppStrings.checkInternet));
    }
  }
}
