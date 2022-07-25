import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/models/video_models/video.dart';
import 'package:mimic/models/video_models/videos_model.dart';
import 'package:mimic/modules/challenges/challange_data_cubit/challange_data_repository.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';

part 'challange_data_state.dart';

class ChallangeDataCubit extends Cubit<ChallangeDataState> {
  ChallangeDataCubit() : super(ChallangeDataInitial());
  static ChallangeDataCubit get(context) => BlocProvider.of(context);
  final ChallangeDataRepository _challangeDataRepository =
      ChallangeDataRepository();
  late Challange challangeDetails;
  late VideosModel videosModel;
  List<Story> videosChallengerslist = [];
  int page = 1;
  List<Story> get videosChallengers {
    return videosModel == null ? [] : videosModel.videos.videos;
  }

  void clear() {
    page = 1;
    videosChallengerslist.clear();
  }

  Future<void> getChallangData({required int challangeId}) async {
    if (await checkInternetConnecation()) {
      emit(ChallangeDataLoading(true));
      try {
        final responses = await Future.wait([
          _challangeDataRepository.challangeDetails(challangeId: challangeId),
          _challangeDataRepository.challangeVideos(challangeId: challangeId)
        ]);
        //log(responses[1].data.toString());
        challangeDetails = Challange.fromJson(responses[0].data['CH']);
        videosModel = VideosModel.fromJson(responses[1].data);
        videosChallengerslist.addAll(videosModel.videos.videos);
        videosModel.videos.videos = videosChallengerslist;
        if (responses[0].data['status'] && responses[1].data['status']) {
          emit(ChallangeDataSuccess());
        }
      } catch (e) {
        rethrow;
      }
    } else {
      emit(ChallangeDataError(AppStrings.checkInternet));
    }
  }

  Future<void> getMoreVideos() async {
    if (await checkInternetConnecation()) {
      ++page;
      emit(ChallangeDataLoading(page == 1));
      try {
        final response = await _challangeDataRepository.challangeVideos(
            challangeId: int.parse(challangeDetails.id), page: page);
        if (response.data['status']) {
          videosModel = VideosModel.fromJson(response.data);
          videosChallengerslist.addAll(videosModel.videos.videos);
          videosModel.videos.videos = videosChallengerslist;
          emit(ChallangeDataSuccess());
        }
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> toggleFavChallenge() async {
    if (await checkInternetConnecation()) {
      challangeDetails.authFavorite = !challangeDetails.authFavorite;
      emit(ChallangeDataSuccess());
      try {
        final response = await _challangeDataRepository.addChallengeToMarked(
            challengeId: int.parse(challangeDetails.id));
        log(response.data.toString());
        if (!response.data['status']) {
          challangeDetails.authFavorite = !challangeDetails.authFavorite;
          emit(ChallangeDataSuccess());
        }
      } catch (e) {
        challangeDetails.authFavorite = !challangeDetails.authFavorite;
        emit(ChallangeDataSuccess());
        rethrow;
      }
    } else {
      emit(ChallangeDataSuccess());
    }
  }

  void rebuildUi() {
    emit(ChallangeDataSuccessAddVideo('your request under review'));
  }

  //add video to challange
}
