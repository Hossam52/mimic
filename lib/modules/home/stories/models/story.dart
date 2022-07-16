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
  });
  late final String id;
  late final User user;
  late final String storyUrl;
  late final String thumbNail;
  late final String MVD;
  late final String R25;

  Story.fromJson(Map<String, dynamic> json) 
  {
    id = SecurityServices.decrypt(json['R0']);
    user = User.fromJson(json['RC']);
    storyUrl = SecurityServices.decrypt(json['VD']);
    thumbNail =SecurityServices.decrypt( json['TH']);
    MVD = SecurityServices.decrypt(json['MVD']);
    R25 = json['R25'];
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