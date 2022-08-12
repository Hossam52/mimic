import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/models/ranks/my_statictics.dart';
import 'package:mimic/models/ranks/rank.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/cached_network_image.dart';

import '../../../../presentation/resourses/styles_manager.dart';

class RankItem extends StatelessWidget {
  const RankItem(
      {Key? key,
      required this.rank,
      required this.myStatictics,
      required this.rankItemMargin,
      required this.rankItemHeight})
      : super(key: key);
  final Rank rank;
  final MyStatictics myStatictics;
  final double rankItemMargin;
  final double rankItemHeight;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          Routes.rankDetails,
          arguments: {'rank': rank, 'myStatictics': myStatictics},
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: rankItemMargin),
        height: rankItemHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: ColorManager.selectedColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 50.w),
                    child: Text(rank.title,
                        style: getSemiBoldStyle(fontSize: FontSize.s14)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 65.w),
                    child:
                        Text('Go to show details..', style: getRegularStyle()),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 21.w),
              child: cachedNetworkImage(
                  imageUrl: rank.imageUrl, height: 92.r, width: 92.r),
            ),
          ],
        ),
      ),
    );
  }
}
