import 'package:mimic/shared/services/security_services.dart';

class Category {
  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });
  late final String id;
  late final String name;
  late final String description;
  late final String image;

  Category.fromJson(Map<String, dynamic> json) {
    id = SecurityServices.decrypt(json['R0']);
    name = SecurityServices.decrypt(json['R8']);
    description = json['R9'] == null
        ? 'description'
        : SecurityServices.decrypt(json['R9']);
    image = SecurityServices.decrypt(json['R5']);
  }

  // Future<void>getNormalData(Map<String,dynamic>json)async
  // {

  // }
}
