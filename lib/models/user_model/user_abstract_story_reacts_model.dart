import 'dart:developer';

import 'package:mimic/models/user_model/user_abstract.dart';
import 'package:mimic/shared/services/security_services.dart';

class UserAbstracStoryReactstModel extends UserAbstract {
  UserAbstracStoryReactstModel(
      {required int id, required String image, int? countReacts})
      : super(id: id, image: image, countReacts: countReacts);
  factory UserAbstracStoryReactstModel.fromJson(Map<String, dynamic> data) {
    log(SecurityServices.decrypt(data['R2']));
    return UserAbstracStoryReactstModel(
      id: int.parse(
        SecurityServices.decrypt(data['R0']),
      ),
      image: SecurityServices.decrypt(data['R1']),
      countReacts: int.parse(SecurityServices.decrypt(data['R2'])),
    );
  }
}
