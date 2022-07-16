part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileGetAllDataLoading extends ProfileState {}

class ProfileGetAllDataSuccess extends ProfileState {}

class ProfileGetAllDataError extends ProfileState {
  final String error;
  ProfileGetAllDataError(this.error);
}

class ProfileGetAllDataNetworkDisable extends ProfileState {
  final String error;
  ProfileGetAllDataNetworkDisable(this.error);
}

class ProfileEditLoading extends ProfileState {}

class ProfileEditSuccess extends ProfileState {}

class ProfileEditError extends ProfileState {
  final String error;
  ProfileEditError(this.error);
}
