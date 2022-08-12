import 'package:mimic/shared/services/security_services.dart';

class AbstractVideoModel {
  final int id;
  final String videoUrl;
  final String thumbNail;
  AbstractVideoModel(
      {required this.id, required this.thumbNail, required this.videoUrl});
  factory AbstractVideoModel.fromJson(Map<String, dynamic> data) 
  {
    return AbstractVideoModel(
        id: int.parse(SecurityServices.decrypt(data['R0'])),
        thumbNail: SecurityServices.decrypt(data['TH']),
        videoUrl: SecurityServices.decrypt(data['VD']));
  }
}
