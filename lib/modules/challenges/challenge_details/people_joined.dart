import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/challenger_profile/challenger_profile.dart';
import 'package:mimic/modules/challenges/challange_data_cubit/challange_data_cubit.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';

class PeopleJoined extends StatelessWidget {
  const PeopleJoined({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChallangeDataCubit challangeDataCubit =
        ChallangeDataCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${challangeDataCubit.challangeDetails.peopleJoined.length} people joined',
          style: getBoldStyle(),
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 30.r,
                child: ListView.separated(
                  itemBuilder: ((context, index) => InkWell(
                        onTap: () {
                          navigateTo(context, Routes.challengerProfile,arguments: challangeDataCubit.challangeDetails.peopleJoined[index].id);
                        },
                        child: cachedNetworkImageProvider(
                            challangeDataCubit
                                .challangeDetails.peopleJoined[index].image,
                            28.r),
                      )),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 10.w,
                  ),
                  itemCount:
                      challangeDataCubit.challangeDetails.peopleJoined.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            // Expanded(
            //   child: Wrap(
            //     spacing: 10,
            //     children: [
            //       for (int i = 0; i < 4; i++)

            //         RoundedImage(
            //           imagePath: 'assets/images/static/avatar.png',
            //           size: 28.r,
            //         )
            //     ],
            //   ),
            // ),
            TextButton(
                onPressed: () {
                  navigateTo(context, Routes.allChallengers);
                },
                child: Text(
                  'VIEW ALL',
                  style: getRegularStyle(fontSize: FontSize.s8)
                      .copyWith(decoration: TextDecoration.underline),
                ))
          ],
        ),
      ],
    );
  }
}
// Widget PeopleJoined(
//       BuildContext context, ChallangeDataCubit challangeDataCubit) {
//     return 
//   }
