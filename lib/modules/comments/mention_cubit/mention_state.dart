part of 'mention_cubit.dart';

@immutable
abstract class MentionState {}

class MentionInitial extends MentionState {}

class MentionLoading extends MentionState {}

class MentionSuccess extends MentionState {}

class MentionRebuildUI extends MentionState {}

class MentionRebuildUIExists extends MentionState {
  final String error;
  MentionRebuildUIExists(this.error);
}

class MentionError extends MentionState {}
