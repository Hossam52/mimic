import 'package:mimic/shared/services/security_services.dart';

import 'city_model.dart';

class Country {
  Country({
    required this.id,
    required this.name,
    required this.cities,
    required this.key,
  });
  late final int id;
  late final String name;
  late final List<City> cities;
  late final String key;

  Country.fromJson(Map<String, dynamic> json) 
  {
    id = int.parse(SecurityServices.decrypt(json['R0']));
    name =SecurityServices.decrypt(json['R8']);
    cities = List.from(json['R10']).map((e) => City.fromJson(e)).toList();
  }
}
