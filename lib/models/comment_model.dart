import 'package:blog_mag/models/user_model.dart';

class CommentModel {
  final int? id;
  final int? ownerId;
  final int? postId;
  final User? user;
  final String? comment;

  const CommentModel({
    this.id,
    this.ownerId,
    this.postId,
    this.user,
    this.comment,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json['id'],
        ownerId: json['owner_id'],
        postId: json['post_id'],
        user: User.fromJson(json['user']),
        comment: json['comment'],
      );

  Map<String, dynamic> toJson() {
    return {
      "post_id": postId,
      "comment": comment,
    };
  }
}
