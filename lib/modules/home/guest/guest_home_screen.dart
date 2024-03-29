// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mimic/modules/home/widgets/black_opacity.dart';
// import 'package:mimic/modules/home/widgets/challenge_item.dart';
// import 'package:mimic/layout/guest/widgets/guest_drawer.dart';
// import 'package:mimic/layout/user/widgets/user_drawer.dart';
// import 'package:mimic/modules/home/widgets/header_name.dart';
// import 'package:mimic/modules/home/widgets/highlight_item.dart';
// import 'package:mimic/modules/home/widgets/highlights.dart';
// import 'package:mimic/widgets/person_details.dart';
// import 'package:mimic/presentation/resourses/color_manager.dart';
// import 'package:mimic/presentation/resourses/font_manager.dart';
// import 'package:mimic/presentation/resourses/routes_manager.dart';
// import 'package:mimic/presentation/resourses/styles_manager.dart';
// import 'package:mimic/shared/methods.dart';
// import 'package:mimic/widgets/mimic_icons.dart';
// import 'package:mimic/widgets/mimic_logo.dart';

// class GuestHomeScreen extends StatelessWidget {
//   GuestHomeScreen({Key? key}) : super(key: key);
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       primary: true,
//       child: Padding(
//         padding: EdgeInsets.only(left: 16.w),
//         child: Column(
//           children: [
//             const Highlights(),
//             SizedBox(height: 16.h),
//             Padding(
//               padding: EdgeInsets.only(right: 11.w),
//               child: const _CurrentChallenges(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _CurrentChallenges extends StatefulWidget {
//   const _CurrentChallenges({Key? key}) : super(key: key);

//   @override
//   State<_CurrentChallenges> createState() => _CurrentChallengesState();
// }

// class _CurrentChallengesState extends State<_CurrentChallenges> {
//   _HeaderEnum selectedHeader = _HeaderEnum.currentChallenges;

//   @override
//   Widget build(BuildContext context) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       Padding(
//         padding: EdgeInsets.only(right: 4.0.w),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             HeaderName(
//               'Current Challenges',
//               fontSize: 18.sp,
//               selected: selectedHeader == _HeaderEnum.currentChallenges,
//               onTap: () {
//                 setState(() {
//                   selectedHeader = _HeaderEnum.currentChallenges;
//                 });
//               },
//             ),
//             HeaderName(
//               'Marked',
//               fontSize: 18.sp,
//               selected: selectedHeader == _HeaderEnum.top,
//               onTap: () {
//                 setState(() {
//                   selectedHeader = _HeaderEnum.top;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//       SizedBox(height: 16.h),
//       ListView.builder(
//           primary: false,
//           shrinkWrap: true,
//           itemCount: 14,
//           itemBuilder: (_, index) {
//             return ChallenegItem(
//               challange:,
//               onJoinTapped: () {
//                 navigateTo(context, Routes.errorGuestPermissions);
//               },
//             );
//           })
//     ]);
//   }
// }

// enum _HeaderEnum { currentChallenges, top }
