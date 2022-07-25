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

class ManageStoriesLoadingProgressUploading extends ManageStoriesState {
  final double progress;
  ManageStoriesLoadingProgressUploading(this.progress);
}

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

class ManageStoriesReactLoading extends ManageStoriesState {}

class ManageStoriesReactSucccess extends ManageStoriesState {}

class ManageStoriesReactError extends ManageStoriesState {
  final String error;
  ManageStoriesReactError(this.error);
}

//view story
class ManageStoriesViewLoading extends ManageStoriesState {}

class ManageStoriesViewSucccess extends ManageStoriesState {}

class ManageStoriesViewError extends ManageStoriesState {
  final String error;
  ManageStoriesViewError(this.error);
}

//friends view my story
class ManageStoriesViewMyStoryLoading extends ManageStoriesState {}

class ManageStoriesViewMyStorySucccess extends ManageStoriesState {
  final List<UserAbstracStoryReactstModel> users;
  ManageStoriesViewMyStorySucccess(this.users);
}

class ManageStoriesViewMyStoryError extends ManageStoriesState {
  final String error;
  ManageStoriesViewMyStoryError(this.error);
}
