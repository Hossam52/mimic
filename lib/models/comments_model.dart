import 'comment_class.dart';
import 'global_models/pegination_model.dart';

class CommentsModel {
  CommentsModel({
    required this.status,
    required this.message,
    required this.comments,
  });
  late final bool status;
  late final String message;
  late final Comments? comments;

  CommentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'] ?? 'Data';
    comments = Comments.fromJson(json['CO']);
  }
}

class Comments {
  Comments({
    required this.comment,
    required this.links,
  });
  late List<Comment> comment;
  late final Links? links;

  Comments.fromJson(Map<String, dynamic>? json) {
    comment = json?['data'] == null
        ? []
        : List.from(json?['data']).map((e) => Comment.fromJson(e)).toList();
    links = json?['links'] == null ? null : Links.fromJson(json?['links']);
  }
}
