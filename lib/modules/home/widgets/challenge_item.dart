import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/modules/home/widgets/images_builder.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class ChallenegItem extends StatelessWidget {
  const ChallenegItem(
      {Key? key, this.onChallengeTapped, required this.onJoinTapped})
      : super(key: key);
  final VoidCallback? onChallengeTapped;
  final VoidCallback onJoinTapped;
  @override
  Widget build(BuildContext context) {
    final double joinIconHeight = 50;
    final halfButtonSize = joinIconHeight / 2;
    return SizedBox(
      height: screenHeight(context) * 0.42,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: GestureDetector(
                onTap: onChallengeTapped,
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Expanded(
                          child: _ChallenegePreview(),
                        ),
                        SizedBox(height: halfButtonSize)
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SizedBox(
                          height: joinIconHeight,
                          child: _joinButton(joinIconHeight, onJoinTapped)),
                    )
                  ],
                ),
              ),
            ),
            Text(
              'Sports challenge details',
              style: getBoldStyle(fontSize: FontSize.s14),
            ),
            Text(
              '12 People joined',
              style: getRegularStyle(),
            ),
            const Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: ImagesBuilder(imagesCount: 10),
            ))
          ],
        ),
      ),
    );
  }

  Widget _joinButton(double height, VoidCallback? onJoinTapped) {
    return Builder(builder: (context) {
      return CircleAvatar(
        radius: height,
        backgroundColor: ColorManager.visibilityColor,
        child: InkWell(
          onTap: onJoinTapped,
          child: Text(
            'Join',
            style:
                getBoldStyle(fontSize: FontSize.s18, color: ColorManager.white),
          ),
        ),
      );
    });
  }
}

class _ChallenegePreview extends StatelessWidget {
  const _ChallenegePreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/static/video_preview.png',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        const BlackOpacity(),
        Icon(
          Icons.play_circle_outline,
          color: ColorManager.white,
          size: 55,
        ),
        Align(alignment: Alignment.bottomLeft, child: _challengeActions()),
      ],
    );
  }

  Widget _challengeActions() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          _actionItem(Icons.favorite, ColorManager.likeColor, '10'),
          const SizedBox(width: 10),
          _actionItem(MimicIcons.comments, ColorManager.commentsColor, '11'),
          const SizedBox(width: 10),
          _actionItem(Icons.visibility, ColorManager.visibilityColor, '12'),
        ],
      ),
    );
  }

  Widget _actionItem(IconData icon, Color color, String count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        Text(
          count,
          style: getRegularStyle(
            color: ColorManager.white,
          ),
        )
      ],
    );
  }
}
