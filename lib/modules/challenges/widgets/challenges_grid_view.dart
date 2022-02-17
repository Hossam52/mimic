import 'package:flutter/material.dart';
import 'package:mimic/modules/challenges/widgets/challenge_person_details.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/widgets/video_statistic_item.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/play_video_icon.dart';

class ChallengesGridView extends StatelessWidget {
  const ChallengesGridView(
      {Key? key,
      this.crossAxisCount = 2,
      required this.itemCount,
      this.showPlayIcon = true})
      : super(key: key);
  final bool showPlayIcon;
  final int crossAxisCount;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: itemCount,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 5 / 7),
        itemBuilder: (_, index) {
          return _ChallengeItemPreview(
            showPlayIcon: showPlayIcon,
          );
        });
  }
}

class _ChallengeItemPreview extends StatelessWidget {
  const _ChallengeItemPreview({Key? key, this.showPlayIcon = true})
      : super(key: key);
  final bool showPlayIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, Routes.challengerVideo);
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/static/video_preview.png',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  const ChallengePersonDetails(),
                  if (showPlayIcon) const BlackOpacity(opacity: 0.4),
                  if (showPlayIcon) const Center(child: PlayVideoIcon()),
                ],
              ),
            ),
            _videoStatistics(context)
          ],
        ),
      ),
    );
  }

  Widget _videoStatistics(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Wrap(
        spacing: 10,
        children: [
          VideStatisticsItem(MimicIcons.favoriteFill, '12',
              filledColor: Theme.of(context).primaryColor),
          VideStatisticsItem(
            MimicIcons.comments,
            '12',
            onPressed: () {
              Dialogs.showCommentsDialog(context);
            },
          ),
          const VideStatisticsItem(Icons.visibility, '12'),
        ],
      ),
    );
  }
}
