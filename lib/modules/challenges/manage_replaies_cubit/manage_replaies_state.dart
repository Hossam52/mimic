part of 'manage_replaies_cubit.dart';

@immutable
abstract class ManageReplaiesState {}

class ManageReplaiesInitial extends ManageReplaiesState {}

class GetAllReplaiesLoading extends ManageReplaiesState {
  final bool isFirst;
  GetAllReplaiesLoading(this.isFirst);
}

class GetAllReplaiesSuccess extends ManageReplaiesState {}

class GetAllReplaiesError extends ManageReplaiesState {
  final String error;
  GetAllReplaiesError(this.error);
}

class AddReplyLoading extends ManageReplaiesState {}

class AddReplySuccess extends ManageReplaiesState {
  final Replay replay;
  AddReplySuccess(this.replay);
}

class AddReplyError extends ManageReplaiesState {
  final String error;
  AddReplyError(this.error);
}

class DeleteReplyLoading extends ManageReplaiesState {}

class DeleteReplySuccess extends ManageReplaiesState {
  final Replay replay;
  DeleteReplySuccess(this.replay);
}

class DeleteReplyError extends ManageReplaiesState {
  final String error;
  DeleteReplyError(this.error);
}

class RebuildUI extends ManageReplaiesState {}
