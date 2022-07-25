import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ffmpeg/statistics.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/video_models/video_info_model.dart';
import 'package:mimic/modules/challenges/add_video_to_challange/cubit/add_video_to_challange_repository.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';
import 'package:mimic/shared/services/video_services.dart';

part 'add_video_to_challange_state.dart';

class ManageVideosChallangersCubit extends Cubit<AddVideoToChallangeState> {
  ManageVideosChallangersCubit() : super(AddVideoToChallangeInitial());
  final ManageVideosChallangersRepository _challangersRepository =
      ManageVideosChallangersRepository();
  static ManageVideosChallangersCubit get(context) => BlocProvider.of(context);
  Future<void> createStory({
    File? videoFile,
    required int challangeId,
  }) async {
    emit(AddVideoToChallangeLoading());
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
            emit(AddVideoToChallangePrepareing(_progress));
          } else {
            emit(AddVideoToChallangeLoading());
          }
        });

        VideoCompressed _videoCompressed =
            await VideoServices.processedVideo(videoFile!, randomVideoName);
        final response = await _challangersRepository.uploadVideoToChallange(
            video: _videoCompressed.videoFiles,
            file: _videoCompressed.thumbnail,
            challangeId: challangeId,
            challangeName: 'title',
            videoName: randomVideoName,
            onProgressUpload: (sent, total) {
              emit(AddVideoToChallangeUploadPreparing((sent / total)));
            });

        log(response.data.toString());
        if (response.data['status']) {
          emit(AddVideoToChallangeSuccess());
        } else {
          emit(AddVideoToChallangeError(response.data['message'].toString()));
        }
      } catch (e) {
        log(e.toString());
        emit(AddVideoToChallangeError(e.toString()));
        return;
      }
    } else {
      emit(AddVideoToChallangeError(AppStrings.checkInternet));
    }
  }
}
