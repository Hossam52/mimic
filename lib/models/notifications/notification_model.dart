import 'package:mimic/models/global_models/pegination_model.dart';
import 'package:mimic/models/notifications/notification.dart';

class NotificationsModel {
  NotificationsModel({
    required this.status,
    required this.notifications,
  });
  late final bool status;
  late final Notifications notifications;

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['ST'];
    notifications = Notifications.fromJson(json['NO']);
  }
}

class Notifications {
  Notifications({
    required this.notifications,
    required this.links,
  });
  List<NotificationData> notifications = [];
  late final Links links;

  Notifications.fromJson(Map<String, dynamic> json) {
    notifications = List.from(json['data'])
        .map((e) => NotificationData.fromJson(e))
        .toList();
    links = Links.fromJson(json['links']);
  }
}
