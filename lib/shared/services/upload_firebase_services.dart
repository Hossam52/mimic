import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class UploadFirebaseServices {
  static Future<String> uploadFileToFirebase(
      String filePath, String folderName) async {
    final file = File(filePath);
    final basename = filePath.split('/').last;

    final ref =
        FirebaseStorage.instance.ref().child(folderName).child(basename);
    UploadTask uploadTask = ref.putFile(file);
    // uploadTask.events.listen(_onUploadProgress);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String videoUrl = await taskSnapshot.ref.getDownloadURL();
    return videoUrl;
  }

  static String getFileExtension(String fileName) {
    return fileName.split('.').last;
  }

  static Future<String> uploadHLSFiles(dirPath, videoName) async {
    final videosDir = Directory(dirPath);
    print(dirPath);
    var playlistUrl = '';
    print('Files Before');
    print(videosDir.path);
    final files = videosDir.listSync(recursive: true);
    int i = 1;
    for (FileSystemEntity file in files) {
      print('Files Paths');
      print(file.path);
      final fileName = file.path.split('/').last;
      final fileExtension = getFileExtension(fileName);
      if (fileExtension == 'm3u8')
        _updatePlaylistUrls(File(file.path), videoName);

      final downloadUrl = await uploadFileToFirebase(file.path, videoName);

      if (fileName == 'master.m3u8') {
        playlistUrl = downloadUrl;
      }
      i++;
    }

    return playlistUrl;
  }

  static void _updatePlaylistUrls(File file, String videoName) {
    final lines = file.readAsLinesSync();
    var updatedLines = [];

    for (final String line in lines) {
      var updatedLine = line;
      if (line.contains('.ts') || line.contains('.m3u8')) {
        updatedLine = '$videoName%2F$line?alt=media';
      }
      updatedLines.add(updatedLine);
    }
    final updatedContents =
        updatedLines.reduce((value, element) => value + '\n' + element);

    file.writeAsStringSync(updatedContents);
  }
}
