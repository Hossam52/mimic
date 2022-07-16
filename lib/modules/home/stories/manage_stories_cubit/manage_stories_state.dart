part of 'manage_stories_cubit.dart';

@immutable
abstract class ManageStoriesState {}

class ManageStoriesInitial extends ManageStoriesState {}

class ManageStoriesPrepareLoading extends ManageStoriesState {
  final double number;
  ManageStoriesPrepareLoading(this.number);
}

class ManageStoriesFinishedPrepared extends ManageStoriesState {}

class ManageStoriesLoadingUploading extends ManageStoriesState {}

class ManageStoriesSucceessUploading extends ManageStoriesState {}

class ManageStoriesErrorUploading extends ManageStoriesState {
  final String error;
  ManageStoriesErrorUploading(this.error);
}

class ManageStoriesLoadingData extends ManageStoriesState {}

class ManageStoriesSuccessData extends ManageStoriesState {}

class ManageStoriesErrorData extends ManageStoriesState {
  final String error;
  ManageStoriesErrorData(this.error);
}
