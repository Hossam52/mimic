
import 'package:mimic/models/user_model/staticticsData.dart';
import 'package:mimic/models/user_model/user.dart';

class UserModel {
  final bool status;
  final String message;
  final User user;
  final StaticticsData staticticsData;
  UserModel(
      {required this.message,
      required this.status,
      required this.user,
      required this.staticticsData});
  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
        staticticsData: StaticticsData.fromJson(data),
        message: data['message'] ?? '',
        status: data['status'] ?? false,
        user: User.fromJson(data['RC']));
  }
}
