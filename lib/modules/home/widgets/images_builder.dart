import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/user_model/user_abstract_model.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';
import 'package:mimic/widgets/rounded_image.dart';

class ImagesBuilder extends StatelessWidget {
  const ImagesBuilder({Key? key, required this.users}) : super(key: key);
  final List<UserAbstractModel> users;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double imageRadius = 45.w;
      final int imagesToRender = constraints.maxWidth ~/ ((imageRadius));
      int maxIndex = min(users.length, imagesToRender);
      // int i = 0;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (int index = 0; index < maxIndex; index++)
              GestureDetector(
                onTap: () => navigateTo(context, Routes.challengerProfile,
                    arguments: users[index].id),
                child:
                    cachedNetworkImageProvider(users[index].image, imageRadius),
              ),
            if (users.length > imagesToRender)
              _lastImage(imageRadius, imagesToRender)
          ],
          // imagesToRender <= users.length
          //     ? users
          //         .map(
          //           (e) => GestureDetector(
          //             onTap: () => navigateTo(
          //                 context, Routes.challengerProfile,
          //                 arguments: e.id),
          //             child: cachedNetworkImageProvider(e.image, imageRadius),
          //           ),
          //         )
          //         .toList()
          //     : users
          //         .map(
          //           (e) => GestureDetector(
          //             onTap: () => navigateTo(
          //                 context, Routes.challengerProfile,
          //                 arguments: e.id),
          //             child: cachedNetworkImageProvider(e.image, imageRadius),
          //           ),
          //         )
          //         .toList()

          // [
          //   for (i = 0; i < imagesToRender.toInt() - 1 && i < users.length; i++)
          //     GestureDetector(
          //       onTap: () => navigateTo(context, Routes.challengerProfile),
          //       child: cachedNetworkImageProvider(users[i].image, imageRadius),
          //       //  Padding(
          //       //   padding: EdgeInsetsDirectional.only(end: 2.w),
          //       //   child: CircleAvatar(
          //       //     backgroundImage: CachedNetworkImageProvider(users[i].image),
          //       //     radius: imageRadius,
          //       //     backgroundColor: ColorManager.primary,
          //       //   ),
          //       //  RoundedImage(
          //       //   imagePath: 'assets/images/static/interest4.png',
          //       //   size: imageRadius,
          //       // ),
          //     ),

          //   // if (i < users.length) _lastImage(imageRadius, i),
          // ],
        ),
      );
    });
  }

  Widget _lastImage(double imageRadius, int imagesToRender) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      children: [
        RoundedImage(
          imagePath: 'assets/images/static/interest3.png',
          size: imageRadius,
        ),
        // BlackOpacity(),
        CircleAvatar(
            backgroundColor: ColorManager.black.withOpacity(0.40),
            radius: imageRadius / 2),
        Center(
          child: Text(
            ' + ${users.length - imagesToRender}',
            style: getRegularStyle(color: ColorManager.white),
          ),
        ),
      ],
    );
  }
}
