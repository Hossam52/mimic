import 'dart:developer';

import 'package:mimic/models/global_models/pegination_model.dart';
import 'package:mimic/models/video_models/video.dart';

class VideosModel {
  VideosModel({
    required this.status,
    required this.videos,
  });
  late final bool status;
  late final Videos videos;

  factory VideosModel.fromJson(Map<String, dynamic> json) {
    return VideosModel(
        status: json['status'], videos: Videos.fromJson(json['VD']));
  }
}

class Videos {
  Videos({
    required this.videos,
    required this.links,
  });
  late final List<Video> videos;
  late final Links links;

  factory Videos.fromJson(Map<String, dynamic> json) {
    return Videos(
        videos: List.from(json['data']).map((e) => Video.fromJson(e)).toList(),
        links: Links.fromJson(json['links']));
  }
}
