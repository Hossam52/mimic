import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/loading_brogress.dart';

class VideoUploadWidget extends StatelessWidget {
   VideoUploadWidget({Key? key,this.color})
      : super(key: key);
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Video uploading now ',
          style: getMediumStyle(fontSize: FontSize.s18),
        ),
        SizedBox(
          height: 15.h,
        ),
         LoadingProgress(color: color,)
        
      ],
    );
  }
}
