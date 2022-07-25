import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/challenge_models/hashtag_model.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/hashtag_item.dart';

class HashTagsWidget extends StatelessWidget {
  const HashTagsWidget({ Key? key ,required this.hashTags}) : super(key: key);
  final List<HashTag>hashTags;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 9.w,
      children: hashTags
          .map((e) => InkWell(
              onTap: () {
                navigateTo(context, Routes.challangesByHashtagId,
                arguments: e);
              },
              child: HashtagItem(title: e.name)))
          .toList(),
    );
  }
}