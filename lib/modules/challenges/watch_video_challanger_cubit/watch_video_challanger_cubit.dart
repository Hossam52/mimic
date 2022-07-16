import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/modules/challenges/watch_video_challanger_cubit/watch_video_challanger_repository.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';

part 'watch_video_challanger_state.dart';

class WatchVideoChallangerCubit extends Cubit<WatchVideoChallangerState> {
  WatchVideoChallangerCubit() : super(WatchVideoChallangerInitial());
  static WatchVideoChallangerCubit get(context) => BlocProvider.of(context);
  final WatchVideoChallangerRepository _watchVideoChallangerRepository =
      WatchVideoChallangerRepository();
  late int videoId;
  Future<void> watchVideoView(int videoId) async {
    if (await checkInternetConnecation()) {
      this.videoId = videoId;
      emit(WatchVideoChallangerLoading());
      try {
        final response =
            await _watchVideoChallangerRepository.watchVideoChallanger(videoId);
        if (response.data['status']) {
          emit(WatchVideoChallangerSuccess());
        } else {
          emit(WatchVideoChallangerError());
        }
      } catch (e) {
        emit(WatchVideoChallangerError());
        rethrow;
      }
    } else {
      emit(WatchVideoChallangerError());
    }
  }

  bool checkVideoViewd(int videoId) => this.videoId == videoId;
}
