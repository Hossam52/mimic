import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/home/stories/models/story.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/presentation/resourses/values_manager.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';

class HighlightItem extends StatelessWidget {
  HighlightItem({Key? key, this.story}) : super(key: key);
  Story? story;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: ColorManager.black.withOpacity(0.5)),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        fit: StackFit.expand,
        clipBehavior: Clip.hardEdge,
        children: [
          _image(story == null ? ValuesManager.imageUrl : story!.thumbNail),
          const BlackOpacity(),
          // Todo::
          PersonDetails(story: story),
        ],
      ),
    );
  }

  Widget _image(String storyImage) {
    return cachedNetworkImage(
        imageUrl: storyImage, height: double.infinity, width: double.infinity);
  }
}

class PersonDetails extends StatelessWidget {
  PersonDetails({Key? key, this.story}) : super(key: key);
  Story? story;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          bottom: AppPadding.p6.h,
          start: AppPadding.p4.w,
          top: AppPadding.p6.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppSize.s28.r,
            height: AppSize.s28.r,
            child: cachedNetworkImageProvider(
                story == null ? ValuesManager.imageUrl : story!.user.image,
                25.r),
          ),
          SizedBox(width: AppSize.s3.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                story == null ? ValuesManager.username : story!.user.name,
                style: getRegularStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s12,
                ),
              ),
              // FittedBox(
              //   fit: BoxFit.scaleDown,
              //   child: Text(
                 
              //     story == null ? '' : story!.R25,
              //     style: getRegularStyle(
              //         color: ColorManager.timeAgo, fontSize: FontSize.s9),
              //   ),
              // )
            ],
          ),
        ],
      ),
    );
  }
}

final _paths = [
  'assets/images/static/highlights/highlight1.png',
  'assets/images/static/highlights/highlight2.png',
  'assets/images/static/highlights/highlight3.png',
];
