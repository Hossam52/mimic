import 'package:mimic/models/user_model/user.dart';

class PeopleModel {
  PeopleModel({
    required this.status,
    required this.users,
  });
  late final bool status;
  List<User> users = [];

  PeopleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    users = List.from(json['RC']).map((e) => User.fromJson(e)).toList();
  }

  // Map<String, dynamic> toJson() {
  //   final _data = <String, dynamic>{};
  //   _data['status'] = status;
  //   _data['RC'] = User.map((e)=>e.toJson()).toList();
  //   return _data;
  // }
}
