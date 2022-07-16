import 'package:mimic/models/user_model/user_abstract.dart';
import 'package:mimic/shared/services/security_services.dart';

class UserAbstractModel extends UserAbstract 
{
  UserAbstractModel({required int id, required String image})
      : super(id: id, image: image);
  factory UserAbstractModel.fromJson(Map<String, dynamic> data) 
  {
    return UserAbstractModel(id: int.parse(SecurityServices.decrypt(data['R0'])),
     image: SecurityServices.decrypt(data['R5']));
  }
}
