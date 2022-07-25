class UserAbstract {
  final int id;
  final String image;
  String? name;
  int? countReacts;
  UserAbstract({required this.id, required this.image, this.name,this.countReacts});
}
