import 'package:mimic/shared/services/security_services.dart';

class City {
  City({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  City.fromJson(Map<String, dynamic> json) {
    id = int.parse(SecurityServices.decrypt(json['R0']));
    name = SecurityServices.decrypt(json['R8']);
  }
}
