import 'package:blog_mag/models/user_model.dart';

class PostModel {
  int? id;
  User? owner;
  String? title;
  String? body;
  String? mediaType;
  String? mediaUrl;
  String? sharingPostId;
  Map<String, dynamic>? sharing;
  int? likesCount;
  int? commentsCount;
  int? sharingsCount;
  bool? isLikeExists;
  DateTime? createdAt;
  DateTime? updatedAt;

  PostModel({
    this.id,
    this.owner,
    this.title,
    this.body,
    this.mediaType,
    this.mediaUrl,
    this.sharingPostId,
    this.sharing,
    this.likesCount,
    this.commentsCount,
    this.sharingsCount,
    this.isLikeExists,
    this.createdAt,
    this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      owner: User.fromJson(json['user']),
      title: json['title'],
      body: json['body'],
      mediaType: json['media_type'],
      mediaUrl: json['media_url'],
      sharingPostId: json['sharing_post_id'],
      sharing: json['sharing'],
      likesCount: json['likes_count'],
      commentsCount: json['comments_count'],
      sharingsCount: json['sharings_count'],
      isLikeExists: json['is_like_exists'],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'media_type': mediaType,
      'media_url': mediaUrl,
      'sharing_post_id': sharingPostId,
    };
  }
}
