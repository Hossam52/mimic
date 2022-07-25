import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/comment_class.dart';
import 'package:mimic/models/global_models/pegination_model.dart';
import 'package:mimic/models/replaies_model.dart';
import 'package:mimic/modules/challenges/manage_replaies_cubit/replies_repository.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';

part 'manage_replaies_state.dart';

class ManageReplaiesCubit extends Cubit<ManageReplaiesState> {
  ManageReplaiesCubit() : super(ManageReplaiesInitial());
  static ManageReplaiesCubit get(context) => BlocProvider.of(context);
  ReplaiesModel replaiesModel = ReplaiesModel(false, [], Links(next: null));
  List<Replay> allReplies = [];
  int? commentId;
  int page = 1;
  String? hint;
  bool expandMore = true;
  bool firstMore = false;
  bool replyFieldOpened = false;
  bool get moreDataAvailable {
    return allReplies.isNotEmpty && replaiesModel.links!.next != null;
  }

  void setData({required int commentId, required String hint}) {
    this.commentId = commentId;
    this.hint = hint;
  }

  void clear() {
    hint = null;
  }

  final RepliesRepository _repliesRepository = RepliesRepository();
  bool checkRebuild(int commentId) => this.commentId == commentId;
  bool checkData(int commentId) {
    if (this.commentId != null && this.commentId == commentId) {
      return true;
    } else {
      allReplies.clear();
      page = 1;
      expandMore = true;
      return false;
    }
  }

  Future<void> getAllReplaies(
    int commentId,
  ) async {
    if (await checkInternetConnecation()) {
      emit(GetAllReplaiesLoading(page == 1));
      checkData(commentId);
      this.commentId = commentId;
      log(this.commentId.toString() + ' ' + commentId.toString());
      log('pageNumber $page');
      try {
        final response = await _repliesRepository.getAllReplies(
          commentId: commentId,
          page: page++,
        );
        if (response.data['status']) {
          replaiesModel = ReplaiesModel.fromJson(response.data);
          log(replaiesModel.links!.next != null ? 'data' : 'no data');
          allReplies.addAll(replaiesModel.replaies);
          replaiesModel.replaies = allReplies;

          emit(GetAllReplaiesSuccess());
        } else {
          emit(GetAllReplaiesError(AppStrings.checkInternet));
        }
      } catch (e) {
        emit(GetAllReplaiesError(AppStrings.checkInternet));

        rethrow;
      }
    } else {
      emit(GetAllReplaiesError(AppStrings.checkInternet));
    }
  }

  Future<void> addReply(
      {required int commentId,
      required String text,
      required List<String> idsMention}) async {
    if (await checkInternetConnecation()) {
      emit(AddReplyLoading());
      try {
        //  log('coId ${commentId} $text ');
        final response = await _repliesRepository.storeNewReplay(
          commentId: commentId,
          body: text,
          idsMention: idsMention,
        );
        log(response.data.toString());
        if (response.data['status']) {
          Replay _reply = Replay.fromJson(response.data['RP']);

          allReplies.add(_reply);
          emit(AddReplySuccess(_reply));
        } else {
          emit(AddReplyError(''));
        }
      } catch (e) {
        emit(AddReplyError(e.toString()));

        rethrow;
      }
    } else {
      emit(AddReplyError(AppStrings.checkInternet));
    }
  }

  //delete reply
  Future<void> deleteReply({required Replay replay}) async {
    if (await checkInternetConnecation()) {
      emit(DeleteReplyLoading());
      try {
        final response =
            await _repliesRepository.deleteReply(replayId: replay.id);
        if (response.data['status']) 
        {
          replaiesModel.replaies.remove(replay);
          emit(DeleteReplySuccess(replay));
        } else {
          emit(DeleteReplyError(''));
        }
      } catch (e) {
        rethrow;
      }
    } else {
      emit(DeleteReplyError(AppStrings.checkInternet));
    }
  }

  void expandMoreToggle() {
    expandMore = !expandMore;
    log('expand rebuild $expandMore');
    emit(RebuildUI());
  }

  void openReplyField() {
    replyFieldOpened = true;
    emit(RebuildUI());
  }
}
