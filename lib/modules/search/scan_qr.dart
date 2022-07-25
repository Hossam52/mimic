import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/widgets/camera._icon.dart';
import 'package:mimic/widgets/gallery_icon.dart';

class ScanQrScreen extends StatelessWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(
        title: 'QR code scan',
      ),
      body: Column(
        children: [
          const Spacer(),
          Expanded(
              flex: 2,
              child: SvgPicture.asset(
                'assets/images/scan_qr.svg',
                fit: BoxFit.fill,
              )),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                GalleryIcon(),
                Expanded(
                  child: Center(child: CameraIcon()),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
