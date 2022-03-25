import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mimic/models/video_models/video_info_model.dart';

class FirebaseProvider {
  static saveVideo(VideoInfo video) async {
    await FirebaseFirestore.instance.collection('videos').add({
      'videoUrl': video.videoUrl,
      'thumbUrl': video.thumbUrl,
      'coverUrl': video.coverUrl,
      'aspectRatio': video.aspectRatio,
      'uploadedAt': video.uploadedAt,
      'videoName': video.videoName,
    });
  }

  static listenToVideos(callback) async {
    FirebaseFirestore.instance.collection('videos').snapshots().listen((data) {
      final videos = mapQueryToVideoInfo(data);
      callback(videos);
    });
  }

  static mapQueryToVideoInfo(QuerySnapshot qs) {
    return qs.docs.map((DocumentSnapshot ds) {
      final dataDoc = ds.data() as Map<String,dynamic>;
      return VideoInfo(
        videoUrl: dataDoc['videoUrl'],
        thumbUrl: dataDoc['thumbUrl'],
        coverUrl: dataDoc['coverUrl'],
        aspectRatio: dataDoc['aspectRatio'],
        videoName: dataDoc['videoName'],
        uploadedAt: dataDoc['uploadedAt'],
      );
    }).toList();
  }
}
