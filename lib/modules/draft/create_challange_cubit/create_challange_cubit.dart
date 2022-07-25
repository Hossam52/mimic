import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ffmpeg/statistics.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/challenge_models/hashtag_model.dart';
import 'package:mimic/models/video_models/video_info_model.dart';
import 'package:mimic/modules/draft/create_challange_cubit/repository_create_challange.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';
import 'package:mimic/shared/services/video_services.dart';

part 'create_challange_state.dart';

class CreateChallangeCubit extends Cubit<CreateChallangeState> {
  CreateChallangeCubit() : super(CreateChallangeInitial());
  static CreateChallangeCubit get(context) => BlocProvider.of(context);
  CreateChallangeRepository createChallangeRepository =
      CreateChallangeRepository();
  List<String> selectedHashtags = [];
  List<HashTag> newHashTags = [];
  Future<void> createChallange({
    required String challangeTitle,
    required String challangeDescription,
    required int categoryId,
    required String endDate,
    File? videoFile,
    required List<String> hashTag,
    required List<HashTag> newHashtagsData,
  }) async {
    emit(CreateChallangeLoading());
    if (await checkInternetConnecation()) {
      try {
        selectedHashtags = hashTag;

        newHashTags = newHashtagsData;
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
            emit(CreateChallangeProgressLoading(_progress));
          } else {
            emit(CreateChallangeUploadLoading());
          }
        });

        VideoCompressed _videoCompressed =
            await VideoServices.processedVideo(videoFile!, randomVideoName);
        List<String> newHashTagsNames = hashTagFilters();
        final response = await createChallangeRepository.createChallange(
            challangeTitle: challangeTitle,
            categoryId: categoryId,
            challangeDescription: challangeDescription,
            endDate: endDate,
            hashTag: selectedHashtags,
            videoData: _videoCompressed.videoFiles,
            thumbNail: _videoCompressed.thumbnail,
            videoName: randomVideoName,
            newHashTags: newHashTagsNames,
            onProgress: (sent, total) {
              emit(CreateChallangeProgressUploadingLoading((sent / total)));
            });

        log(response.data.toString());
        if (response.data['status']) {
          emit(CreateChallangeSuccess());
        } else 
        {
          emit(CreateChallangeError(response.data['message'].toString()));
        }
      } catch (e) {
        log(e.toString());
        emit(CreateChallangeError(e.toString()));
        return;
      }
    } else {
      emit(CreateChallangeError(AppStrings.checkInternet));
    }
  }

  List<String> hashTagFilters() {
    List<String> newHashtagsNames = [];
    bool isExist = false;
    for (int index = 0; index < newHashTags.length; index++) {
      isExist = selectedHashtags.remove(newHashTags[index].id.toString());
      if (isExist) {
        newHashtagsNames.add(newHashTags[index].name);
      }
    }

    return newHashtagsNames;
  }
}
