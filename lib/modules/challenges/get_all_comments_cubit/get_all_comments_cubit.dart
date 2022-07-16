import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/comment_class.dart';
import 'package:mimic/models/comments_model.dart';
import 'package:mimic/modules/challenges/get_all_comments_cubit/comments_repository.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';

part 'get_all_comments_state.dart';

class GetAllCommentsCubit extends Cubit<GetAllCommentsState> {
  GetAllCommentsCubit() : super(GetAllCommentsIdle());
  static GetAllCommentsCubit get(context) => BlocProvider.of(context);
  late CommentsModel commentsModel;
  int? videoId;
  int page = 1;
  late List<Comment> comments = [];
  List<Comment> allComments = [];
  final CommentsRepository _commentsRepository = CommentsRepository();
  bool checkRebuild(int videoId) => this.videoId == videoId;
  bool checkData(int videoId) {
    if (this.videoId != null && this.videoId == videoId) {
      return true;
    } else {
      allComments.clear();
      comments.clear();
      page = 1;
      return false;
    }
  }

  Future<void> getAllComments(
    int videoId, {
    int page = 1,
  }) async {
    if (await checkInternetConnecation()) {
      this.videoId = videoId;
      emit(GetAllCommentsLoading(page == 1));
      try {
        final response = await _commentsRepository.getAllComments(
            videoId: videoId, page: page);

        commentsModel = CommentsModel.fromJson(response.data);
        allComments.addAll(commentsModel.comments!.comment);
        commentsModel.comments!.comment = allComments;
        emit(GetAllCommentsSuccess(allComments));
      } catch (e) {
        emit(GetAllCommentsError(''));
        rethrow;
      }
    } else {
      emit(GetAllCommentsError(AppStrings.checkInternet));
    }
  }

  Future<void> addComment({required int videoId, required String text}) async {
    if (await checkInternetConnecation()) {
      emit(AddCommentLoading());
      try {
        final response = await _commentsRepository.storeNewComment(
            videoId: videoId, body: text);
        if (response.data['status']) {
          Comment _comment = Comment.fromJson(response.data['CO']);
          allComments.add(_comment);
          emit(AddCommentSuccess());
        } else {
          emit(AddCommentError(''));
        }
      } catch (e) {
        rethrow;
      }
    } else {
      emit(AddCommentError(AppStrings.checkInternet));
    }
  }
  Future<void>deleteComment({required Comment comment})async
  {
     if (await checkInternetConnecation()) {
      emit(DeleteCommentLoading());
      try {
        final response = await _commentsRepository.deleteComment(
          commentId: comment.id);
        if (response.data['status']) {
    commentsModel.comments!.comment.remove(comment);
          
          emit(DeleteCommentSuccess());
        } else {
          emit(DeleteCommentError(''));
        }
      } catch (e) {
        rethrow;
      }
    } else {
      emit(DeleteCommentError(AppStrings.checkInternet));
    }
  }
  void deleteCommentUI(Comment comment) {
    commentsModel.comments!.comment.remove(comment);
    emit(GetAllCommentsRebuild());
  }

  void rebuild() {
    emit(GetAllCommentsRebuild());
  }

  // Future<void> toggleLike(
  //     {bool isComment = true, Comment? comment, int? replayId}) async {
  //   comment!.liked = !comment.liked;
  //   if (comment.liked) {
  //     comment.likesCount++;
  //   } else {
  //     comment.likesCount--;
  //   }
  //   emit(ToggleLikeLoading());
  //   try {
  //     final response = await DioHelper.postData(
  //         url: ConstantHelper.toggleLike,
  //         data: isComment ? {'comment_id': comment.id} : {'reply_id': replayId},
  //         token: ConstantHelper.tokenValue);
  //     if (response.data['status']) {
  //       emit(ToggleLikeSuccess());
  //     } else {
  //       comment.liked = !comment.liked;
  //       if (!comment.liked)
  //         comment.likesCount++;
  //       else
  //         comment.likesCount--;
  //       emit(ToggleLikeError());
  //     }
  //   } catch (e) {
  //     emit(ToggleLikeError());
  //     throw e;
  //   }
  // }

  // Future<void> toggleLikeReplay(
  //     {required Replay replay,
  //     required int replayId,
  //     required int commentIndex}) async {
  //   replay.liked = !replay.liked;
  //   if (replay.liked)
  //     replay.likesCount++;
  //   else
  //     replay.likesCount--;
  //   emit(ToggleLikeLoading());
  //   try {
  //     final response = await postData(
  //       url: ConstantHelper.toggleLike,
  //       data: {'reply_id': replayId},
  //     );
  //     if (response.data['status']) {
  //       emit(ToggleLikeSuccess());
  //     } else {
  //       replay.liked = !replay.liked;
  //       if (!replay.liked)
  //         replay.likesCount++;
  //       else
  //         replay.likesCount--;
  //       emit(ToggleLikeError());
  //     }
  //   } catch (e) {
  //     emit(ToggleLikeError());
  //     throw e;
  //   }
  // }

  // Future<void> addReplay(
  //     {required String textReplay,
  //     required int id,
  //     required int index,
  //     File? image}) async {
  //   emit(AddCommentOrReplyLoadingState());
  //   try {
  //     FormData data = FormData.fromMap({
  //       'text': textReplay,
  //       'comment_id': id,
  //       'image': image == null ? null : await HelperMethods.uploadFile(image)
  //     });
  //     final response = await DioHelper.postData(
  //         url: ConstantHelper.addReplay,
  //         data: data,
  //         token: ConstantHelper.tokenValue);
  //     //   print(response.data);
  //     // print(response.data);
  //     if (response.data['status']) {
  //       Replay replay = Replay.fromJson(response.data['reply']);
  //       emit(AddCommentOrReplySuccessState(replay));
  //       commentsModel.comments!.comment[index].replies.add(replay);
  //     } else
  //       emit(AddCommentOrReplyErrorState(response.data['message']));
  //   } catch (e) {
  //     emit(AddCommentOrReplyErrorState(ConstantHelper.serverError));
  //     throw e;
  //   }
  // }

  // Future<void> updateReplay({
  //   required String text,
  //   required int commentId,
  //   required int replayId,
  //   required int commentIndex,
  //   required int replayIndex,
  //   required bool deleteImage,
  //   File? image,
  //   File? file,
  // }) async {
  //   emit(UpdateCommentOrReplyLoadingState());
  //   try {
  //     FormData data = FormData.fromMap(
  //       {
  //         'text': text,
  //         'comment_id': commentId,
  //         'reply_id': replayId,
  //         'files[]': file == null ? null : await HelperMethods.uploadFile(file),
  //         if (deleteImage) 'deleteimage': deleteImage,
  //         if (!deleteImage)
  //           'image':
  //               image == null ? null : await HelperMethods.uploadFile(image)
  //       },
  //     );
  //     final response =
  //         await postData(url: ConstantHelper.updateReplay, data: data);
  //     print(response.data);
  //     if (response.data['status']) {
  //       Replay replay = Replay.fromJson(response.data['reply']);
  //       commentsModel.comments!.comment[commentIndex].replies[replayIndex] =
  //           replay;
  //       emit(UpdateCommentOrReplySuccessState(replay));
  //     } else
  //       emit(response.data['message']);
  //   } catch (e) {
  //     emit(UpdateCommentOrReplyErrorState(ConstantHelper.serverError));
  //     throw e;
  //   }
  // }

  // Future<void> deleteReplay(
  //     {required int replayId,
  //     required int commentIndex,
  //     required int replayIndex}) async {
  //   emit(DeleteCommentOrReplyLoadingState());
  //   try {
  //     final response = await postData(
  //         url: ConstantHelper.deleteReplay, data: {'reply_id': replayId});
  //     if (response.data['status']) {
  //       commentsModel.comments!.comment[commentIndex].replies
  //           .removeAt(replayIndex);
  //       emit(DeleteCommentOrReplySuccessState());
  //     } else
  //       emit(response.data['message']);
  //   } catch (e) {
  //     emit(DeleteCommentOrReplyErrorState(ConstantHelper.serverError));
  //     throw e;
  //   }
  // }
}
