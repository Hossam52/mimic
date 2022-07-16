part of 'get_all_comments_cubit.dart';

@immutable
abstract class GetAllCommentsState {}

class GetAllCommentsIdle extends GetAllCommentsState {}

class GetAllCommentsLoading extends GetAllCommentsState {
  final bool isFirst;
  GetAllCommentsLoading(this.isFirst);
}

class GetAllCommentsSuccess extends GetAllCommentsState {
  final List<Comment> comments;
  GetAllCommentsSuccess(this.comments);
}

class GetAllCommentsRebuild extends GetAllCommentsState {}

class GetAllCommentsError extends GetAllCommentsState {
  final String error;
  GetAllCommentsError(this.error);
}

class AddCommentLoading extends GetAllCommentsState {}

class AddCommentSuccess extends GetAllCommentsState {}

class AddCommentError extends GetAllCommentsState 
{
  final String error;
  AddCommentError(this.error);
}
class DeleteCommentLoading extends GetAllCommentsState {}

class DeleteCommentSuccess extends GetAllCommentsState {}

class DeleteCommentError extends GetAllCommentsState 
{
  final String error;
  DeleteCommentError(this.error);
}

class ToggleLikeLoading extends GetAllCommentsState {}

class ToggleLikeSuccess extends GetAllCommentsState {}

class ToggleLikeError extends GetAllCommentsState {}

class AddCommentOrReplyLoadingState extends GetAllCommentsState {}

class AddCommentOrReplySuccessState extends GetAllCommentsState {
  final Replay replay;
  AddCommentOrReplySuccessState(this.replay);
}

class AddCommentOrReplyErrorState extends GetAllCommentsState {
  final String error;
  AddCommentOrReplyErrorState(this.error);
}

//updateReplay
class UpdateCommentOrReplyLoadingState extends GetAllCommentsState {}

class UpdateCommentOrReplySuccessState extends GetAllCommentsState {
  final Replay replay;
  UpdateCommentOrReplySuccessState(this.replay);
}

class UpdateCommentOrReplyErrorState extends GetAllCommentsState {
  final String error;
  UpdateCommentOrReplyErrorState(this.error);
}

//Delete Replay
class DeleteCommentOrReplyLoadingState extends GetAllCommentsState {}

class DeleteCommentOrReplySuccessState extends GetAllCommentsState {}

class DeleteCommentOrReplyErrorState extends GetAllCommentsState {
  final String error;
  DeleteCommentOrReplyErrorState(this.error);
}
