import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/challenges/challange_data_cubit/challange_data_cubit.dart';
import 'package:mimic/modules/challenges/widgets/challenges_grid_view.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';

class AllChallengers extends StatelessWidget {
  const AllChallengers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ChallangeDataCubit.get(context),
      child: Scaffold(
        appBar: const TransparentAppBar(title: 'All challenges'),
        body: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: ChallengesGridView(
            showPlayIcon: false,
            context: context,
          ),
        ),
      ),
    );
  }
}
