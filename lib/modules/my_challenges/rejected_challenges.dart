import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/layout/my_challenges/cubit/my_challenges_cubit.dart';
import 'package:mimic/layout/my_challenges/cubit/my_challenges_states.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/modules/my_challenges/widgets/all_categories_drop_down.dart';
import 'package:mimic/modules/my_challenges/widgets/my_challenge_item.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/widgets/custom_drop_down.dart';
import 'package:mimic/widgets/loading_brogress.dart';
import 'package:mimic/widgets/play_video_icon.dart';
import 'package:mimic/widgets/rounded_image.dart';
import 'package:mimic/widgets/shadow_box.dart';

class RejectedChallenges extends StatelessWidget {
  const RejectedChallenges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyChallengesCubit, MyChallengesStateState>(
      builder: (context, state) {
        if (state is ErrorMyChallengesCubit) {
          return BuildErrorWidget(state.error);
        } else if (state is SuccessMyChallengesCubit) {
          return Padding(
            padding: EdgeInsets.only(top: AppPadding.p20.h),
            child: Column(
              children: [
                const AllCategoriesDropDown(),
                Expanded(
                    child: _rejectedChallenges(
                        MyChallengesCubit.instance(context).challanges)),
              ],
            ),
          );
        } else {
          return const LoadingProgress();
        }
      },
    );
  }

  Widget _rejectedChallenges(Set<Challange> challanges) {
    return ListView.builder(
      itemCount: challanges.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Dialogs.showRejectedVideoReason(context);
            },
            child: MyChallengeItem(
              challange: challanges.elementAt(index),
            ));
      },
    );
  }
}
