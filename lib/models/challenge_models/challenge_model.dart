import 'dart:developer';

import 'package:mimic/models/global_models/pegination_model.dart';
import 'package:mimic/models/user_model/user.dart';
import 'package:mimic/models/user_model/user_abstract.dart';
import 'package:mimic/models/user_model/user_abstract_model.dart';
import 'package:mimic/models/video_models/video.dart';
import 'package:mimic/shared/services/security_services.dart';

class ChallengesModel {
  ChallengesModel({
    required this.status,
    required this.challenges,
  });
  late final bool status;
  late final Challenges challenges;

  ChallengesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    challenges = Challenges.fromJson(json['CH']);
  }
}

class Challenges {
  Challenges({
    required this.data,
    required this.links,
  });
  late final List<Challange> data;
  late final Links links;

  Challenges.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Challange.fromJson(e)).toList();
    links = Links.fromJson(json['links']);
  }
}

class Challange {
  Challange({
    required this.id,
    required this.challangeTitle,
    required this.description,
    required this.category,
    required this.endDate,
    //required this.R15,
    required this.peopleJoined,
    required this.createdAt,
    required this.hashtags,
    required this.shareCount,
    required this.authCreator,
    required this.creator,
    //  required this.R21,
  });
  late final String id;
  late final String r8;
  late final String challangeTitle;
  late final String description;
  late final String category;
  late final String endDate;
  late final String status;
  late bool authJoined;
  late final List<UserAbstractModel> peopleJoined;
  late final String createdAt;
  late final User creator;
  late final Video videoCreator;

  late final List<String> hashtags;
  late final String shareCount;
  late final bool authCreator;
  List<Video> videos = [];
  late int commentsNumber;
  late int likesNumber;
  late int views;

  Challange.fromJson(Map<String, dynamic> json) {
    id = SecurityServices.decrypt(json['R0']);
    challangeTitle = SecurityServices.decrypt(json['R12']);
    description = SecurityServices.decrypt(json['R9']);
    category = SecurityServices.decrypt(json['R13']);
    endDate = SecurityServices.decrypt(json['R14']);
    creator = User.fromJson(json['R15']);
    authJoined = json['R44'];
    peopleJoined = json['R22'] == null
        ? []
        : json['R22'] is String
            ? []
            : List.from(json['R22'])
                .map((e) => UserAbstractModel.fromJson(e))
                .toList();
    createdAt = SecurityServices.decrypt(json['R16']);
    log(json['R17'].toString());
    hashtags = List.from(json['R17'])
        .map((e) => SecurityServices.decrypt(e['R8']))
        .toList();
    //   List.from(json['R17']).map((e) => SecurityServices.decrypt(e)).toList();

    shareCount = SecurityServices.decrypt(json['R19']);
    authCreator =
        SecurityServices.decrypt(json['R20']) == "true" ? true : false;
    log(json['R21'].toString());
    videoCreator = Video.fromJson(json['R21']);
    //videos = [];
    commentsNumber =
        true ? 3 : int.parse(SecurityServices.decrypt(json['R40']));
    likesNumber = int.parse(SecurityServices.decrypt(json['R42']));
    views = int.parse(SecurityServices.decrypt(json['R43']));
    //  json['R21'] == null
    //     ? []
    //     : List.from(json['R21']).map((e) => Video.fromJson(e)).toList();
  }
}
