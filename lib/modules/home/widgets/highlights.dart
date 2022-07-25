import 'package:flutter/material.dart';
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
    ManageStoriesCubit manageStoriesCubit = ManageStoriesCubit.get(context);
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
        
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 15.w,
                // childAspectRatio: 150 / 106,
                // mainAxisExtent: 106.w,
                childAspectRatio: 150 / 116),
            itemBuilder: (_, index) {
              if (index == 0) {
                return GestureDetector(
                    // onLongPress: manageStoriesCubit.getStories.myStories.isEmpty
                    //     ? null
                    //     : () => navigateTo(context, Routes.viewMyStories,
                    //         arguments:
                    //             ManageStoriesCubit.get(context).getStories),
                    onTap: () {
                      if (manageStoriesCubit.getStories.myStories.isEmpty) {
                        navigateTo(context, Routes.addStory,
                            arguments: context);
                      } else {
                        navigateTo(context, Routes.viewMyStories,
                            arguments:
                                ManageStoriesCubit.get(context).getStories);
                      }
                    },
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        HighlightItem(
                            story:
                                manageStoriesCubit.getStories.myStories.isEmpty
                                    ? null
                                    : manageStoriesCubit
                                        .getStories.myStories.first),
                        if (manageStoriesCubit.getStories.myStories.isEmpty)
                          Container(
                            height: 60.h,
                            width: double.maxFinite,
                            alignment: Alignment.center,
                            child: Text(
                              AppStrings.addToStory.translateString(context),
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
                        if (manageStoriesCubit.getStories.myStories.isEmpty)
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
              return InkWell(
                  onTap: () {
                    navigateTo(context, Routes.viewFriendsStories, arguments: {
                      'friends': manageStoriesCubit.getStories.OSV,
                      'index': index - 1
                    });
                  },
                  child: HighlightItem(
                      story:
                          manageStoriesCubit.getStories.OSV.data[index - 1]));
            },
            itemCount: manageStoriesCubit.getStories.OSV.data.length + 1,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }
}
