import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/challenge_models/hashtag_model.dart';
import 'package:mimic/modules/challenges/challanges_by_hashtag/challange_by_hashtag_cubit/challange_by_hashtag_cubit.dart';
import 'package:mimic/modules/home/widgets/challenge_item.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_appbar.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class ChallangesByHashtagScreen extends StatelessWidget {
  ChallangesByHashtagScreen({Key? key}) : super(key: key);
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    HashTag hashtag = ModalRoute.of(context)!.settings.arguments as HashTag;
    late ChallangeByHashtagCubit _challangeByHashtagCubit;
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        if (_challangeByHashtagCubit.challengesModel.challenges.links.next !=
            null) {
          _challangeByHashtagCubit.getAllChallangesByHashtagId(
              hashtagId: hashtag.id);
        }
      }
    });
    return BlocProvider(
      create: (context) => ChallangeByHashtagCubit()
        ..getAllChallangesByHashtagId(hashtagId: hashtag.id),
      lazy: false,
      child: Scaffold(
        // appBar: app,
        appBar: defaultAppbar(
            title: '#${hashtag.name}', backgroundColr: ColorManager.white),
        body: BlocBuilder<ChallangeByHashtagCubit, ChallangeByHashtagState>(
          builder: (context, state) {
            if (state is ChallangeByHashtagLoading && state.isFirst) {
              return const LoadingProgress();
            } else if (state is ChallangeByHashtagError) {
              return BuildErrorWidget(state.error);
            } else {
              _challangeByHashtagCubit = ChallangeByHashtagCubit.get(context);
              return Padding(
                padding: EdgeInsetsDirectional.only(
                    start: AppPadding.p10.w, end: AppPadding.p10.w),
                child: RefreshIndicator(
                  onRefresh: () async {
                    _challangeByHashtagCubit.clear();
                    _challangeByHashtagCubit.getAllChallangesByHashtagId(
                        hashtagId: hashtag.id);
                  },
                  child: _challangeByHashtagCubit.allChallanges.isEmpty
                      ? const BuildErrorWidget(
                          AppStrings.noAvailableChallangesInThisHashtag)
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  controller: controller,
                                  itemCount: _challangeByHashtagCubit
                                      .allChallanges.length,
                                  itemBuilder: (_, index) {
                                    return ChallenegItem(
                                      challange: _challangeByHashtagCubit
                                          .allChallanges[index],
                                      onJoinTapped: () {},
                                      onChallengeTapped: () {
                                        navigateTo(
                                            context, Routes.challengeDetails,
                                            arguments: _challangeByHashtagCubit
                                                .allChallanges[index].id);
                                      },
                                    );
                                  }),
                            ),
                            if (state is ChallangeByHashtagLoading)
                              const LoadingProgress(),
                          ],
                        ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
