
import 'package:mimic/shared/services/security_services.dart';

class HashTagModel {
  final bool status;
  final Set<HashTag> hashtags;
  HashTagModel({required this.hashtags, required this.status});
  factory HashTagModel.fromJson(Map<String, dynamic> data) {
    return HashTagModel(
        status: data['status'],
        hashtags:
            Set.from(data['hashtags']).map((e) => HashTag.fromJson(e)).toSet());
  }
}

class HashTag {
  final int id;
  final String name;
  HashTag({required this.id, required this.name});
  factory HashTag.fromJson(Map<String, dynamic> data) {
    return HashTag(
        id:data['R0']==null? 1:int.parse(SecurityServices.decrypt(data['R0'])),
        name: SecurityServices.decrypt(data['R8']));
  }
}
