import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/layout/my_challenges/cubit/my_challenges_cubit.dart';
import 'package:mimic/layout/my_challenges/cubit/my_challenges_states.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/modules/my_challenges/widgets/all_categories_drop_down.dart';
import 'package:mimic/modules/my_challenges/widgets/my_challenge_item.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class RejectedChallenges extends StatelessWidget {
  RejectedChallenges({Key? key}) : super(key: key);
  int? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppPadding.p20.h),
      child: Column(
        children: [
          AllCategoriesDropDown(onChange: (value) {
            selectedCategory = int.parse(value);
            MyChallengesCubit.instance(context).getMyChallengesFilterd(
              categoryId: selectedCategory,
            );
          }),
          Expanded(
            child: BlocBuilder<MyChallengesCubit, MyChallengesStateState>(
              builder: (context, state) {
                if (state is ErrorMyChallengesCubit) {
                  return BuildErrorWidget(state.error);
                } else if (state is SuccessMyChallengesCubit) {
                  return _rejectedChallenges(
                    MyChallengesCubit.instance(context).challanges,
                  );
                } else {
                  return const LoadingProgress();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
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
