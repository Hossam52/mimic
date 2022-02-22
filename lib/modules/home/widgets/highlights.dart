import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/home/widgets/header_name.dart';
import 'package:mimic/modules/home/widgets/highlight_item.dart';
import 'package:mimic/shared/methods.dart';

class Highlights extends StatelessWidget {
  const Highlights({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderName(
            'Highlights',
            fontSize: 17.sp,
            selected: true,
            displaySelectedIndicator: false,
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 160.h,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 15,
                  // childAspectRatio: 150 / 106,
                  // mainAxisExtent: 106.w,
                  childAspectRatio: 150 / 116),
              itemBuilder: (_, index) {
                return const HighlightItem();
              },
              itemCount: 5,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
