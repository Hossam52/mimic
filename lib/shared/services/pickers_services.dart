import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickerServices {
  static final _imagePicker = ImagePicker();
  static Future<File?> pickImage() async {
    final pickImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) return File(pickImage.path);
    return null;
  }

  static Future<File?> pickVideo({bool sourceGallery = true}) async {
    final pickedFile = await _imagePicker.pickVideo(
      source: sourceGallery ? ImageSource.gallery : ImageSource.camera,
      maxDuration: const Duration(seconds: 30),
    );
    if (pickedFile != null) return File(pickedFile.path);
    return null;
  }
}
