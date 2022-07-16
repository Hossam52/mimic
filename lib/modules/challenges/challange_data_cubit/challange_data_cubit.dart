import 'dart:developer';

import 'package:bloc/bloc.dart';
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
  late VideosModel _videosModel;
  //List<Video> videosChallengers = [];
  List<Video> get videosChallengers {
    return _videosModel == null ? [] : _videosModel.videos.videos;
  }

  Future<void> getChallangData({required int challangeId}) async {
    if (await checkInternetConnecation()) {
      emit(ChallangeDataLoading());
      try {
        final responses = await Future.wait([
          _challangeDataRepository.challangeDetails(challangeId: challangeId),
          _challangeDataRepository.challangeVideos(challangeId: challangeId)
        ]);
        //log(responses[1].data.toString());
        challangeDetails = Challange.fromJson(responses[0].data['CH']);
        _videosModel = VideosModel.fromJson(responses[1].data);
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
  //add video to challange
}
