import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickerServices 
{
  static final _imagePicker = ImagePicker();
 static Future<File?> pickVideo({bool sourceGallery = true}) async 
  {
    final pickedFile = await _imagePicker.pickVideo(
      source: sourceGallery ? ImageSource.gallery : ImageSource.camera,
      maxDuration: const Duration(seconds: 60),
    );
    if (pickedFile != null) return File(pickedFile.path);
    return null;
  }
}
