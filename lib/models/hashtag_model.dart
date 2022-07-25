import 'package:mimic/shared/services/security_services.dart';

class HashtagModel {
  final int id;
  final String name;
  HashtagModel({required this.id, required this.name});
  factory HashtagModel.fromJson(Map<String, dynamic> data) {
    
    return HashtagModel(id: int.parse(SecurityServices.decrypt(data['R0'])),
     name: SecurityServices.decrypt(data['R8']));
  }
}
