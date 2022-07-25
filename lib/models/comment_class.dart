
import 'package:mimic/models/user_model/user.dart';
import 'package:mimic/shared/services/security_services.dart';

class MainCommentData {
  late final int id;
  late final String text;
  late final User user;
  late int likesCount;
  late bool liked;
  String? image;
  late final String date;
}

class Comment with MainCommentData {
  Comment({
    required this.userComment,
    required this.replies,
    required this.hour,
  });

  late final bool userComment;
  late final String hour;
  Replay? replay;
  List<Replay> replies = [];
  int numOfReplies=0;

  Comment.fromJson(Map<String, dynamic> json) {
    id = int.parse(SecurityServices.decrypt(json['R0']));
    numOfReplies = int.parse(SecurityServices.decrypt(json['R29']));
    text = json['R28'] == null ? '' : SecurityServices.decrypt(json['R28']);

    user = User.fromJson(json['RC']);
    likesCount = json['R23'] == null
        ? 0
        : int.parse(SecurityServices.decrypt(json['R23']));
    userComment = json['MC'] == null
        ? false
        : SecurityServices.decrypt(json['MC']) == 'false'
            ? false
            : true;
    image =
        json['image'] == null ? null : SecurityServices.decrypt(json['image']);
    // replies = json['RP'] == null
    //     ? []
    //     : List.from(json['RP']).map((e) => Replay.fromJson(e)).toList();
    replay = json['LRP'] == null ? null : Replay.fromJson(json['LRP']);
    date = SecurityServices.decrypt(json['R30']);
    liked = json['AL'];
    // json['AL'] == ''
    //     ? false
    //     : SecurityServices.decrypt(json['AL']) == '1'
    //         ? true
    //         : false;
  }
}

//
class Replay extends MainCommentData {
  Replay({
    required this.userReplay,
  });

  late final bool userReplay;

  Replay.fromJson(Map<String, dynamic> json) {
    id = int.parse(SecurityServices.decrypt(json['R0']));
    image = json['image'];
    text = json['R28'] == null ? '' : SecurityServices.decrypt(json['R28']);
    user = User.fromJson(json['RC']);
    likesCount = json['R23'] == null
        ? 0
        : int.parse(SecurityServices.decrypt(json['R23']));
    userReplay = json['R30'] == null
        ? false
        : SecurityServices.decrypt(json['R30']) == 'false'
            ? false
            : true;
    date = SecurityServices.decrypt(json['R33']);
    liked = json['R32'];
  }
}
