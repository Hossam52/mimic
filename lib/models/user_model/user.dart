import 'dart:developer';

import 'package:mimic/shared/services/security_services.dart';

class User {
  late final int id;
  late final String name;
  late final String email;
  late final String country;
  late final String city;
  late final String image;
  late final int rank;
  late final String dataOfBirth;
  late final String clientCode;
  late final String description;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.country,
    required this.city,
    required this.rank,
    required this.dataOfBirth,
    required this.clientCode,
    required this.description,
  });
  factory User.fromJson(Map<String, dynamic> userData) {
    return User(
      id: int.parse(SecurityServices.decrypt(userData['R0'])),
      name: SecurityServices.decrypt(userData['R1']),
      email: SecurityServices.decrypt(userData['R2']),
      country: SecurityServices.decrypt(userData['R3']),
      city: SecurityServices.decrypt(userData['R4']),
      image: SecurityServices.decrypt(userData['R5']),
      rank: 1,
      dataOfBirth: SecurityServices.decrypt(userData['R7']),
      clientCode: userData['R8'] == null
          ? 'null'
          : SecurityServices.decrypt(userData['R8']),
      description: userData['R9'] == null
          ? ''
          : SecurityServices.decrypt(userData['R9']),
    );
  }
}
