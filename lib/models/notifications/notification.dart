import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:mimic/models/user_model/user_abstract_model.dart';
import 'package:mimic/models/video_models/abstract_video_model.dart';
import 'package:mimic/shared/services/security_services.dart';

// abstract class Notification extends Equatable
// {
//   @override
//   List<Object?> get props => [];

// }
// class NotificationTag extends Notification{}
// class NotificationCommentOrReply extends Notification{}
// class NotificationAdmin extends Notification{}
//
class NotificationData {
  NotificationData({
    required this.id,
    required this.title,
    required this.body,
    required this.notificationType,
    required this.readAt,
    required this.createdAt,
    required this.sender,
    required this.commentId,
    required this.replyId,
    this.Video,
  });
  late final int id;
  late final String title;
  late final String body;
  late final String notificationType;
  late final bool readAt;
  late final String createdAt;
  UserAbstractModel? sender;
  int? commentId;
  int? challengeId;
  String? notificationSatus;

  int? replyId;
  late final AbstractVideoModel? Video;

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = int.parse(SecurityServices.decrypt(json['R0']));
    notificationSatus = json['RST'];
    title = SecurityServices.decrypt(json['RT']);
    body = SecurityServices.decrypt(json['RB']);
    notificationType = SecurityServices.decrypt(json['RTY']);
    // log(notificationType);

    readAt = json['RD'];

    createdAt = DateFormat('yyyy-MM-dd hh:mm')
        .format(DateTime.parse(SecurityServices.decrypt(json['D'])));
    sender = json['RS'] == null ? null : UserAbstractModel.fromJson(json['RS']);
    challengeId = json['C'];
    commentId = json['CO'];
    replyId = json['RE'];
    Video = json['V'] == null ? null : AbstractVideoModel.fromJson(json['V']);
  }
}
