// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:mimic/modules/home/widgets/black_opacity.dart';
// import 'package:mimic/modules/home/widgets/challenge_item.dart';
// import 'package:mimic/layout/guest/widgets/guest_drawer.dart';
// import 'package:mimic/layout/user/widgets/user_drawer.dart';
// import 'package:mimic/modules/home/widgets/header_name.dart';
// import 'package:mimic/modules/home/widgets/highlight_item.dart';
// import 'package:mimic/modules/home/widgets/person_details.dart';
// import 'package:mimic/presentation/resourses/color_manager.dart';
// import 'package:mimic/presentation/resourses/font_manager.dart';
// import 'package:mimic/presentation/resourses/styles_manager.dart';
// import 'package:mimic/shared/methods.dart';
// import 'package:mimic/widgets/mimic_icons.dart';
// import 'package:mimic/widgets/mimic_logo.dart';

// class HomeScreen extends StatelessWidget {
//   HomeScreen({Key? key}) : super(key: key);
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         centerTitle: true,
//         title: MimicLogo(width: screenWidth(context) * 0.25),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           onPressed: () {
//             scaffoldKey.currentState?.openDrawer();
//           },
//           icon: Icon(
//             MimicIcons.menu,
//             color: Theme.of(context).primaryColor,
//           ),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 MimicIcons.notifications,
//                 color: Theme.of(context).primaryColor,
//               ))
//         ],
//       ),
//       drawer: UserDrawer(),
//       body: SingleChildScrollView(
//         primary: true,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: screenHeight(context) * 0.26,
//                 child: const _Highlights(),
//               ),
//               const _CurrentChallenges(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _Highlights extends StatelessWidget {
//   const _Highlights({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const HeaderName('Highlights'),
//         const SizedBox(height: 10),
//         Expanded(
//           child: GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 1,
//               mainAxisSpacing: 15,
//               childAspectRatio: 4 / 3,
//             ),
//             itemBuilder: (_, index) {
//               return const HighlightItem();
//             },
//             itemCount: 5,
//             scrollDirection: Axis.horizontal,
//           ),
//         )
//       ],
//     );
//   }
// }

// class _CurrentChallenges extends StatelessWidget {
//   const _CurrentChallenges({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: const [
//           HeaderName('Current Challeneges'),
//           HeaderName('Top', opacity: 0.49),
//         ],
//       ),
//       ListView.builder(
//           primary: false,
//           shrinkWrap: true,
//           itemCount: 14,
//           itemBuilder: (_, index) {
//             return const Padding(
//               padding: EdgeInsets.symmetric(vertical: 8.0),
//               child: ChallenegItem(),
//             );
//           })
//     ]);
//   }
// }
