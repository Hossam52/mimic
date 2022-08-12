part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {
  final bool isFirst;
  const NotificationsLoading(this.isFirst);
}

class NotificationsSuccess extends NotificationsState {}

class NotificationsError extends NotificationsState {
  final String error;
  const NotificationsError(this.error);
}

//get notification count
class NotificationsCountLoading extends NotificationsState {}

class NotificationsCountSuccess extends NotificationsState {}

class NotificationsCountError extends NotificationsState {
  final String error;
 const NotificationsCountError(this.error);
}

class NotificationsDeleteNotificationLoading extends NotificationsState {}

class NotificationsDeleteNotificationSuccess extends NotificationsState {}

class NotificationsDeleteNotificationError extends NotificationsState {
  final String error;
  const NotificationsDeleteNotificationError(this.error);
}
