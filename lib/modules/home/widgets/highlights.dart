import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/home/stories/manage_stories_cubit/manage_stories_cubit.dart';
import 'package:mimic/modules/home/widgets/header_name.dart';
import 'package:mimic/modules/home/widgets/highlight_item.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/shared/methods.dart';

class Highlights extends StatelessWidget {
  const Highlights({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderName(
          AppStrings.highlights.translateString(context),
          fontSize: FontSize.s17,
          selected: true,
          displaySelectedIndicator: false,
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 160.h,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 15,
                // childAspectRatio: 150 / 106,
                // mainAxisExtent: 106.w,
                childAspectRatio: 150 / 116),
            itemBuilder: (_, index) {
              if (index == 0) 
              {
                return GestureDetector(
                   onLongPress: ()=>navigateTo(context, Routes.viewMyStories,arguments: ManageStoriesCubit.get(context).getStories),
                    onTap: () {
                      navigateTo(context, Routes.addStory);
                    },
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        const HighlightItem(),
                        Container(
                          height: 60.h,
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          child: Text(
                            'Add to story',
                            style: getBoldStyle(fontSize: FontSize.s14),
                          ),
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12.r),
                              bottomRight: Radius.circular(12.r),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 40.h,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.all(5.r),
                              child: Icon(
                                Icons.add,
                                color: ColorManager.black,
                                size: AppSize.largeIconSize,
                              ),
                              decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: ColorManager.white)),
                            ),
                          ),
                        )
                      ],
                    ));
              }
              return const HighlightItem();
            },
            itemCount: 5,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }
}
