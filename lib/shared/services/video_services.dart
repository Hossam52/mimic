import 'dart:developer';
import 'dart:io';

import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

import 'package:mimic/models/video_models/video_info_model.dart';
import 'package:path_provider/path_provider.dart';


class VideoServices {
  //1- generate thumbnail with w*h of the video
  static final FlutterFFmpeg _encoder = FlutterFFmpeg();
  //2- get media info of the video
  static final FlutterFFprobe _probe = FlutterFFprobe();
  static final FlutterFFmpegConfig _config = FlutterFFmpegConfig();
  static double videoDuration = 0;

  //-i => video path
  //-vframes to get one frame form video
  // -s => size of thumbnail
  // -ss outpath of thumbnail
  static Future<String> getThumb(videoPath, width, height) async {
    assert(File(videoPath).existsSync());

    final String outPath = '$videoPath.jpg';
    final arguments =
        '-y -i $videoPath -vframes 1 -an -s ${width}x$height -ss 1 $outPath';

    final int rc = await _encoder.execute(arguments);
    assert(rc == 0);
    assert(File(outPath).existsSync());

    return outPath;
  }

//get video info
  static Future<Map<dynamic, dynamic>?> getMediaInformation(String path) async {
    final mediaInformation = await _probe.getMediaInformation(path);
    return mediaInformation.getAllProperties();
  }

  static double getAspectRatio(Map<dynamic, dynamic> info) {
    print('Info');
    print(info);
    final int width = info['streams'][0]['width'];
    final int height = info['streams'][0]['height'];
    final double aspect = height / width;
    return aspect;
  }

  static double getDuration(Map<dynamic, dynamic> info) {
    double _duration = double.parse(info['format']['duration']);
    return double.parse(_duration.toStringAsFixed(2));
  }

//encode video to hls files
  static Future<String> encodeHLS(
      String videoPath, String outDirPath, String videoName) async {
    assert(File(videoPath).existsSync());
    // final arguments = '-y -i $videoPath ' +
    //     '-preset ultrafast -g 48 -sc_threshold 0 ' +
    //     '-map 0:0 -map 0:1 -map 0:0 -map 0:1 ' +
    //     '-c✌0 libx264 -b✌0 2000k ' +
    //     '-c✌1 libx264 -b✌1 365k ' +
    //     '-c:a copy ' +
    //     '-var_stream_map "v:0,a:0 v:1,a:1" ' +
    //     '-master_pl_name master.m3u8 ' +
    //     '-f hls -hls_time 6 -hls_list_size 0 ' +
    //     '-hls_segment_filename "$outDirPath/%v_${fileName}_%d.ts" ' +
    //     '$outDirPath/%v_playlistVariant.m3u8';
    // final arg = '-y ' +
    //     '-i $videoPath ' +
    //     '-preset ultrafast -g 48 -sc_threshold 0 ' +
    //     '-map 0:0 -map 0:1 -map 0:0 -map 0:1 ' +
    //     '-c✌0 libx264 -b✌0 2000k ' +
    //     '-c✌1 libx264 -b✌1 365k ' +
    //     '-c:a copy ' +
    //     '-var_stream_map "v:0,a:0 v:1,a:1" ' +
    //     '-master_pl_name master.m3u8 ' +
    //     '-f hls -hls_time 6 -hls_list_size 0 ' +
    //     '-hls_segment_filename "$outDirPath/%v_fileSequence_%d.ts" ' +
    //     '$outDirPath/%v_playlistVariant.m3u8';
    //-b:0 360p -b:1 480 -b:2 720
    //-c:1 libx264 -b:1 365k
    final args =
        '-i $videoPath -c:0 libx264 -b:0 365k -master_pl_name $videoName.m3u8  -f hls -hls_time 10 -hls_list_size 0 -hls_segment_filename "$outDirPath/%v_${videoName}_%d.ts"  $outDirPath/%v_$videoName.m3u8';
    final rc = await _encoder.execute(args);

    // final int rc = await _probe.executeWithArguments(
    //   argumentsList,
    // );
    // print(rc);
    assert(rc == 0);

    return outDirPath;
  }

  static Future<VideoCompressed> processedVideo(
      File videoPath, String randomVideoName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final videoName = 'video${DateTime.now().millisecondsSinceEpoch}';
    final outputPath = '${directory.path}/mimicVideos/$videoName';
    final outputDirectoryVideos = Directory(outputPath);
    outputDirectoryVideos.createSync(recursive: true);
    final videoInfoData = await getMediaInformation(videoPath.path);
    final aspectRatioVideo = getAspectRatio(videoInfoData!);
    videoDuration = getDuration(videoInfoData);
    //1- generate thumbnail
    final imageThumbPath = await getThumb(videoPath.path, 200, 200);
    final outputDirPath =
        await encodeHLS(videoPath.path, outputPath, randomVideoName);
    List<File>videoFiles=await getListOfVideoFile(outputDirPath);
    VideoCompressed videoCompressed=VideoCompressed(thumbnail: File(imageThumbPath),
    videoFiles: videoFiles,
    );
    // final thumbUrl = await UploadFirebaseServices.uploadFileToFirebase(
    //     imageThumbPath, 'thumbnails');
    // final videoUrl =
    //     await UploadFirebaseServices.uploadHLSFiles(outputDirPath, videoName);
    return videoCompressed;
    //save video on firestore
    // final videoInfo = VideoInfo(
    //   videoUrl: videoUrl,
    //   thumbUrl: thumbUrl,
    //   coverUrl: thumbUrl,
    //   aspectRatio: aspectRatioVideo,
    //   uploadedAt: DateTime.now().millisecondsSinceEpoch,
    //   videoName: videoName,
    // );
    // await FirebaseProvider.saveVideo(videoInfo);
  }

  //get list of video files
  static Future<List<File>> getListOfVideoFile(String dirPath) async {
    final videosDir = Directory(dirPath);
    log(dirPath);
    log('Files Before');
    log(videosDir.path);
    final files = videosDir.listSync(recursive: true);
    return files.map((e) => File(e.path)).toList();
  }

  //to get statisitcs
  static void enableStatisticsCallback({required Function cb}) {
    return _config.enableStatisticsCallback((statistics) {
      cb(statistics);
      // log(statistics.time.toString());
      // log(statistics.speed.toString());
      // log(statistics.size.toString());
    });
  }

  static Future<void> cancel() async {
    await _encoder.cancel();
  }

  static void enableLogCallback(Function logCallback) {
    _config.enableLogCallback((log) => logCallback(log));
  }
}
