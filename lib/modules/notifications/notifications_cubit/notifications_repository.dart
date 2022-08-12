import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class NotificationRepository {
  Future<Response> getAllNotification({int page = 1}) async {
    return await HandlingApis.getData(
        url: ConstantHelper.getAllNotifications, quary: {'page': page});
  }

  Future<Response> deleteNotification({required int notificationId}) async {
    return await HandlingApis.postData(
        url: ConstantHelper.deleteNotification,
        data: 
        {
          'notify_id': notificationId,
        },);
  }
  Future<Response> changeNotificationState({required int notificationId}) async {
    return await HandlingApis.postData(
        url: ConstantHelper.changeNotificationState,
        data: 
        {
          'notify_id': notificationId,
        },);
  }

  Future<Response> readAllNotification() async {
    return await HandlingApis.getData(url: ConstantHelper.readNotification);
  }
  Future<Response> getNotificationsCountUnreaded() async {
    return await HandlingApis.getData(url: ConstantHelper.getNotificationCount);
  }
}
