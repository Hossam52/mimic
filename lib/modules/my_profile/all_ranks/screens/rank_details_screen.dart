import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/ranks/my_statictics.dart';
import 'package:mimic/models/ranks/rank.dart';
import 'package:mimic/modules/my_profile/all_ranks/widgets/level_item_requirements.dart';
import 'package:mimic/modules/my_profile/all_ranks/widgets/my_statistics_data.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/widgets/default_appbar.dart';

class RankDetailsScreen extends StatelessWidget {
  const RankDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Rank rank = data['rank'];
    final MyStatictics myStatictics = data['myStatictics'];
    return Scaffold(
      appBar: defaultAppbar(
        backgroundColr: ColorManager.white,
        title: AppStrings.levelDetails.translateString(context),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        child: Column(
          children: [
            LevelItemRequirements(rank: rank),
            SizedBox(
              height: AppSize.s10,
            ),
            MyStatictiscsWidget(myStatictics: myStatictics, levelId: rank.id),
          ],
        ),
      ),
    );
  }
}
