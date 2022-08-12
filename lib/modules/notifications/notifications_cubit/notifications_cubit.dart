import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimic/models/notifications/notification.dart';
import 'package:mimic/models/notifications/notification_model.dart';
import 'package:mimic/modules/notifications/notifications_cubit/notifications_repository.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());
  static NotificationsCubit get(context) => BlocProvider.of(context);
  int page = 1;
  int notificationCountUnreaded = 0;
  final NotificationRepository _notificationRepository =
      NotificationRepository();
  late Notifications notificationsModel;
  List<NotificationData> allNotifications = [];
  void init() {
    page = 1;
    allNotifications = [];
  }

  int checkNotificationsUnreaded() {
    if (state is! NotificationsCountLoading &&
        state is! NotificationsCountError) return notificationCountUnreaded;
    return 0;
  }

  bool checkFoundMore() {
    return notificationsModel == null
        ? false
        : notificationsModel.links.next != null;
  }

  Future<void> getAllNotifications() async {
    if (await checkInternetConnecation()) {
      emit(NotificationsLoading(page == 1));
      try {
        if (page == 1 && notificationCountUnreaded != 0) {
          await _notificationRepository.readAllNotification();
          notificationCountUnreaded = 0;
        }
        final response =
            await _notificationRepository.getAllNotification(page: page++);
        // log(response.data.toString());
        if (response.data['ST']) {
          notificationsModel = Notifications.fromJson(response.data['NO']);
          allNotifications.addAll(notificationsModel.notifications);
          notificationsModel.notifications = allNotifications;
        }
        emit(NotificationsSuccess());
      } catch (e) {
        emit(NotificationsError(e.toString()));
        rethrow;
      }
    } else {
      emit(const NotificationsError(AppStrings.checkInternet));
    }
  }

  Future<void> getNotificationCount() async {
    if (await checkInternetConnecation()) {
      emit(NotificationsCountLoading());
      try {
        final response =
            await _notificationRepository.getNotificationsCountUnreaded();
        log('Notifications');
        notificationCountUnreaded = response.data['CR'] ?? 0;
        log(response.data.toString());
        emit(NotificationsCountSuccess());
      } catch (e) {
        emit(NotificationsCountError(e.toString()));
        rethrow;
      }
    } else {
      emit(const NotificationsCountError(AppStrings.checkInternet));
    }
  }

  Future<void> deleteNotification(
      {required int notificationId, required int index}) async {
    if (await checkInternetConnecation()) {
      emit(NotificationsDeleteNotificationLoading());
      try {
        final response = await _notificationRepository.deleteNotification(
            notificationId: notificationId);
        log(response.data.toString());
        allNotifications.removeAt(index);
        emit(NotificationsDeleteNotificationSuccess());
      } catch (e) {
        emit(NotificationsDeleteNotificationError(e.toString()));
        rethrow;
      }
    } else {
      emit(
          const NotificationsDeleteNotificationError(AppStrings.checkInternet));
    }
  }

  Future<void> changeNotificationState(
      {required int notificationId, required int notificationIndex}) async {
    if (await checkInternetConnecation()) {
      allNotifications[notificationIndex].notificationSatus = 1;
      emit(NotificationsSuccess());
      final response = await _notificationRepository.changeNotificationState(
          notificationId: notificationId);
      log(response.data.toString());
    }
  }
}
