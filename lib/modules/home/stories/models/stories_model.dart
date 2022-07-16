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

  FriendsStories.fromJson(Map<String, dynamic> json) 
  {
    data = List.from(json['data']).map((e) => Story.fromJson(e)).toList();
    links = Links.fromJson(json['links']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data;
    _data['links'] = links.toJson();
    return _data;
  }
}

class Links {
  Links({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });
  late final String first;
  late final String last;
  late final Null prev;
  late final Null next;

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = null;
    next = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first'] = first;
    _data['last'] = last;
    _data['prev'] = prev;
    _data['next'] = next;
    return _data;
  }
}
