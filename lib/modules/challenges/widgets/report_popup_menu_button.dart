import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class ReportPopupMenuButton extends StatelessWidget {
  const ReportPopupMenuButton({Key? key, this.iconColor}) : super(key: key);
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy + 20,
            details.globalPosition.dx,
            details.globalPosition.dy + 20,
          ),
          items: [
            PopupMenuItem(
                value: 'report',
                onTap: () async {
                  Future.delayed(const Duration(seconds: 0), () async {
                    await Dialogs.showReportDialog(context);
                  });
                },
                child: Row(
                  children: [
                    Icon(MimicIcons.country,
                        color: Theme.of(context).primaryColor),
                    const SizedBox(width: 10),
                    Text(
                      'Report',
                      style: getRegularStyle(
                        fontSize: FontSize.s16,
                      ),
                    ),
                  ],
                ))
          ],
        );
      },
      onTap: () {},
      child: Icon(
        Icons.more_vert,
        color: iconColor,
      ),
    );
  }
}
