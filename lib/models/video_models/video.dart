import 'dart:developer';

import 'package:better_player/better_player.dart';
import 'package:mimic/models/user_model/user.dart';
import 'package:mimic/shared/services/security_services.dart';

class Video {
  Video({
    required this.id,
    required this.R12,
    required this.user,
    required this.createdAt,
    required this.videoUrl,
    required this.myVideo,
    required this.authLike,
    required this.commentNumber,
    required this.likeNumber,
    required this.numberOfwatches,
    required this.R25,
    required this.reasons,
    required this.thumNailUrl,
  });
  late final String id;
  late final String R12;
  late final User user;
  late final String createdAt;
  late final String videoUrl;
  late final String myVideo;
  late bool authLike;
  late int commentNumber;
  int likeNumber;
  int numberOfwatches;
  late final String R25;
  late final String reasons;
  late final String thumNailUrl;
  late BetterPlayerController controller =
      BetterPlayerController(const BetterPlayerConfiguration());

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
        id: SecurityServices.decrypt(json['R0']),
        R12: SecurityServices.decrypt(json['R12']),
        user: User.fromJson(json['RC']),
        createdAt: SecurityServices.decrypt(json['R16']),
        videoUrl: SecurityServices.decrypt(json['VD']),
        myVideo: SecurityServices.decrypt(json['MVD']),
        authLike: json['AL'],
        //    SecurityServices.decrypt(json['AL']) == 'false' ? false : true,
        commentNumber: int.parse(SecurityServices.decrypt(json['R22'])),
        likeNumber: int.parse(SecurityServices.decrypt(json['R23'])),
        numberOfwatches: int.parse(SecurityServices.decrypt(json['R24'])),
        R25: SecurityServices.decrypt(json['R25']),
        thumNailUrl: SecurityServices.decrypt(json['TH']),
        //R26
        reasons: '');
  }
}
