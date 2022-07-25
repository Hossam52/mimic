import 'dart:developer';

import 'package:mimic/models/user_model/user.dart';
import 'package:mimic/shared/services/security_services.dart';

class Story {
  Story({
    required this.id,
    required this.user,
    required this.storyUrl,
    required this.thumbNail,
    required this.MVD,
    required this.R25,
    required this.authView,
  });
  late final int id;
  late final User user;
  late final String storyUrl;
  late final String thumbNail;
  late final String MVD;
  late final String R25;
  late bool authView;
  late int watchCount;

  Story.fromJson(Map<String, dynamic> json) {
    // log('story message');
    // log(json.toString());
    // log('myStory');
    // log(json.toString());
    id = int.parse(SecurityServices.decrypt(json['R0']));

    String watch = SecurityServices.decrypt(json['WC']);
    watchCount = watch.isEmpty ? 0 : int.parse(watch);
    user = User.fromJson(json['RC']);
    storyUrl = SecurityServices.decrypt(json['VD']);
    thumbNail = SecurityServices.decrypt(json['TH']);
    MVD = SecurityServices.decrypt(json['MVD']);

    authView = json['AW'];
    R25 = json['R25'] == null ? '' : SecurityServices.decrypt(json['R25']);
  }

  // Map<String, dynamic> toJson() {
  //   final _data = <String, dynamic>{};
  //   _data['R0'] = id;
  //   _data['RC'] = user.toJson();
  //   _data['VD'] = storyUrl;
  //   _data['TH'] = thumbNail;
  //   _data['MVD'] = MVD;
  //   _data['R25'] = R25;
  //   return _data;
  // }
}
