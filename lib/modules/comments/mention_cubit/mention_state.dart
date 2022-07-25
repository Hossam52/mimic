part of 'mention_cubit.dart';

@immutable
abstract class MentionState {}

class MentionInitial extends MentionState {}
class MentionLoading extends MentionState {}
class MentionSuccess extends MentionState {}
class MentionError extends MentionState {}


