import 'category.dart';

class CategoriesModel {
  CategoriesModel({
    required this.status,
    required this.categories,
  });
  late final bool status;
  late final Categories categories;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    categories = Categories.fromJson(json['categories']);
  }
}

class Categories {
  Categories({
    required this.categories,
  });
  late final List<Category> categories;

  Categories.fromJson(Map<String, dynamic>? json) {
    categories = json == null
        ? []
        : List.from(json['data']).map((e) => Category.fromJson(e)).toList();
  }
}
