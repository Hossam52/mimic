import 'dart:developer';

import 'package:mimic/models/global_models/pegination_model.dart';
import 'package:mimic/modules/home/stories/models/story.dart';

class StoriesModel {
  StoriesModel({
    required this.status,
    required this.myStories,
    required this.OSV,
  });
  late final bool status;
  late final List<Story> myStories;
  late final FriendsStories OSV;

  StoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    myStories = List.from(json['MSV']).map((e) => Story.fromJson(e)).toList();
    log(myStories.length.toString());
    OSV = FriendsStories.fromJson(json['OSV']);
  }

  // Map<String, dynamic> toJson() {
  //   final _data = <String, dynamic>{};
  //   _data['status'] = status;
  //   _data['MSV'] = MSV.map((e) => e.toJson()).toList();
  //   _data['OSV'] = OSV.toJson();
  //   return _data;
  // }
}

class FriendsStories {
  FriendsStories({
    required this.data,
    required this.links,
  });
  late final List<Story> data;
  late final Links links;

  FriendsStories.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    data = List.from(json['data']).map((e) => Story.fromJson(e)).toList();
    // links = Links.fromJson(json['links']);
  }
}
