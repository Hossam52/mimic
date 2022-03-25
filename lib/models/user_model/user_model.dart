import 'package:mimic/models/user_model/user.dart';

class UserModel {
  final bool status;
  final String message;
  final User user;
  UserModel({required this.message, required this.status, required this.user});
  factory UserModel.fromJson(Map<String, dynamic> data) 
  {
    return UserModel(
        message: data['message'],
        status: data['status'],
        user: User.fromJson(data['RC']));
  }
}
