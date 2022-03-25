class VideoInfo {
  final String videoUrl;
  final String thumbUrl;
  final String coverUrl;
  final double aspectRatio;
  final int uploadedAt;
  final String videoName;

  VideoInfo(
      {
       required this.videoUrl,
      required this.thumbUrl,
      required this.coverUrl,
      required this.aspectRatio,
      required this.uploadedAt,
      required this.videoName});
}