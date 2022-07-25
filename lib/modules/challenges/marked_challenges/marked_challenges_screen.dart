import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimic/modules/challenges/marked_challenges/marked_challenges_cubit/marked_challenges_cubit.dart';
import 'package:mimic/modules/home/widgets/challenge_item.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_appbar.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class MarkedChallengesScreen extends StatelessWidget {
  const MarkedChallengesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
        title: AppStrings.marked.translateString(context),
        backgroundColr: ColorManager.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p10.w),
        child: BlocProvider(
          create: (context) => MarkedChallengesCubit()..getFavChallenges(),
          child: BlocConsumer<MarkedChallengesCubit, MarkedChallengesState>(
            listener: (context, state) {
              if (state is MarkedChallengesError &&
                  state.error == AppStrings.checkInternet) {
                Fluttertoast.showToast(
                    msg: state.error, backgroundColor: ColorManager.error);
              }
            },
            builder: (context, state) {
              if (state is MarkedChallengesLoading && state.isFirst) {
                return const LoadingProgressSearchChallanges();
              } else if (state is MarkedChallengesError &&
                  MarkedChallengesCubit.get(context).allFavChallenges.isEmpty) {
                return const BuildErrorWidget(
                  AppStrings.noAvailableChallanges,
                );
              } else {
                MarkedChallengesCubit markedChallengesCubit =
                    MarkedChallengesCubit.get(context);
                return ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ChallenegItem(
                          challange:
                              markedChallengesCubit.allFavChallenges[index],
                          onJoinTapped: () {},
                          onChallengeTapped: () {
                            navigateTo(context, Routes.challengeDetails,
                                arguments: markedChallengesCubit
                                    .allFavChallenges[index].id);
                          },
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 5.h,
                        ),
                    itemCount: markedChallengesCubit.allFavChallenges.length);
              }
            },
          ),
        ),
      ),
    );
  }
}
