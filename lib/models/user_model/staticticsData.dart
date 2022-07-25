class StaticticsData {
  final int numberOfVideos;
  final int numberOfLikes;
  final int numberOfContrubtion;

  StaticticsData(
      {required this.numberOfVideos,
      required this.numberOfLikes,
      required this.numberOfContrubtion});
  factory StaticticsData.fromJson(Map<String, dynamic> data) {
    //data not found

    return StaticticsData(
        numberOfVideos: data['VC'] ?? 0,
        numberOfLikes: data['LC'] ?? 0,
        numberOfContrubtion: data['CC'] ?? 0);
  }
}
