import 'package:mimic/shared/services/security_services.dart';

class Rank {
  final int id;
  final String title;
  final String imageUrl;
  final int challengesNumber;
  final int likesNumber;
  final int videosNumber;
  final int invitesNumber;
  final bool authLevel;
  Rank(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.challengesNumber,
      required this.likesNumber,
      required this.videosNumber,
      required this.invitesNumber,
      required this.authLevel});
  factory Rank.fromJson(Map<String, dynamic> json) {
    return Rank(
        id: int.parse(SecurityServices.decrypt(json['R0'])),
        title: SecurityServices.decrypt(json['R35']),
        imageUrl: SecurityServices.decrypt(json['R37']),
        challengesNumber: int.parse(SecurityServices.decrypt(json['RCN'])),
        likesNumber: int.parse(SecurityServices.decrypt(json['RLN'])),
        videosNumber: int.parse(SecurityServices.decrypt(json['RVN'])),
        invitesNumber: int.parse(SecurityServices.decrypt(json['RIN'])),
        authLevel: json['R41']);
  }
}
