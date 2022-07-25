import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/modules/challenges/likes_cubit/likes_repository.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';

part 'likes_state.dart';

class LikesCubit extends Cubit<LikesState> {
  LikesCubit() : super(const LikesInitial(false));
  static LikesCubit get(context) => BlocProvider.of(context);
  late int selectedId;
  final LikesRepository _likesRepository = LikesRepository();
  Future<void> toggleLikeVideo(int videoId, {required bool liked}) async {
    liked = !liked;
    selectedId = videoId;
    if (await checkInternetConnecation()) {
      emit(LikesLoading(liked, videoId));
      try {
        final response = await _likesRepository.toggleLikeVideo(videoId);
        if (response.data['status']) {
          emit(LikesSuccess(liked, videoId));
        } else {
          liked = !liked;
          emit(LikesError(liked, videoId));
        }
      } catch (e) {
        liked = !liked;
        emit(LikesError(liked, videoId));
      }
    }
  }

  Future<void> toggleLikeComment(int commentId, {required bool liked}) async {
    liked = !liked;
    selectedId = commentId;
    if (await checkInternetConnecation()) {
      emit(LikesLoading(liked, selectedId));
      try {
        final response = await _likesRepository.toggleLikeComment(commentId);
        if (response.data['status']) {
          emit(LikesSuccess(liked, commentId));
        } else {
          liked = liked;
          emit(LikesError(liked, commentId));
        }
      } catch (e) {
        liked = liked;
        emit(LikesError(liked, commentId));
      }
    }
  }
  Future<void> toggleLikeReplay(int replayId, {required bool liked}) async {
    liked = !liked;
    selectedId = replayId;
    if (await checkInternetConnecation()) {
      emit(LikesLoading(liked, selectedId));
      try {
        final response = await _likesRepository.toggleLikeReplay(replayId);
        if (response.data['status']) {
          emit(LikesSuccess(liked, replayId));
        } else {
          liked = liked;
          emit(LikesError(liked, replayId));
        }
      } catch (e) {
        liked = liked;
        emit(LikesError(liked, replayId));
      }
    }
  }

  bool checkLikeProccessed({required int id}) => selectedId == id;
}
