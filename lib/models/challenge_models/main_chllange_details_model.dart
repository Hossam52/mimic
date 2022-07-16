import 'package:mimic/models/user_model/user.dart';
import 'package:mimic/models/user_model/user_abstract_model.dart';
import 'package:mimic/models/video_models/video.dart';

class MainChallangeDetails
{
   late final String id;
  late final String r8;
  late final String challangeTitle;
  late final String description;
  late final String category;
  late final String endDate;
  late final String status;
  late final List<UserAbstractModel> peopleJoined;
  late final String createdAt;
  late final User creator;
  late final Video videoCreator;

  late final String hashtags;
  late final String shareCount;
  late final bool authCreator;
  late int commentsNumber;
  late int likesNumber;
  late int views;
  MainChallangeDetails({
    required this.id,
    required this.challangeTitle,
    required this.description,
    required this.category,
    required this.endDate,
    //required this.R15,
    required this.peopleJoined,
    required this.createdAt,
    required this.hashtags,
    required this.shareCount,
    required this.authCreator,
    required this.creator,
    //  required this.R21,
  });
  
}