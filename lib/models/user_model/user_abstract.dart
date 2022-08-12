import 'package:equatable/equatable.dart';

class UserAbstract extends Equatable {
  final int id;
  final String image;
  String? name;
  int? countReacts;
  UserAbstract({required this.id, required this.image, this.name,this.countReacts});
  
  @override
  List<Object?> get props => [id,image,name,countReacts];
}
