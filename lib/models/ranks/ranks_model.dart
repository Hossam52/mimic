import 'dart:developer';

import 'package:mimic/models/ranks/my_statictics.dart';

import 'rank.dart';

class RanksModel {
  final bool status;
  final int myRank;
  final MyStatictics myStatictics;

  List<Rank> ranks = [];

  RanksModel({
    required this.status,
    required this.ranks,
    required this.myRank,
    required this.myStatictics,
    
  });

  factory RanksModel.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return RanksModel(
        myRank: json['MR'],
        myStatictics: MyStatictics(myChallengesCount: json['RCN'],
        authLevel: json['MR'],
         myLikesCount: json['RLN'],
        myVideosCount: json['RVN'],
        myInvitesCount: json['RIN'],
        ),
       
        status: json['status'],
        ranks: List.from(json['RK']).map((e) => Rank.fromJson(e)).toList());
  }
}
