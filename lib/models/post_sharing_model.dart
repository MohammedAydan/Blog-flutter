// import 'package:blog/models/user_model.dart';
//
// class PostSharingModel {
//   final int? id;
//   final User? owner;
//   final String? title;
//   final String? body;
//   final String? mediaType;
//   final String? mediaUrl;
//   final String? sharingPostId;
//   final PostSharingModel? sharing;
//   final int? likesCount;
//   final int? commentsCount;
//   final int? sharingsCount;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   PostSharingModel({
//     this.id,
//     this.owner,
//     this.title,
//     this.body,
//     this.mediaType,
//     this.mediaUrl,
//     this.sharingPostId,
//     this.sharing,
//     this.likesCount,
//     this.commentsCount,
//     this.sharingsCount,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory PostSharingModel.fromJson(Map<String, dynamic> json) {
//     return PostSharingModel(
//       id: json['id'],
//       owner: User.fromJson(json['user']),
//       title: json['title'],
//       body: json['body'],
//       mediaType: json['media_type'],
//       mediaUrl: json['media_url'],
//       sharingPostId: json['sharing_post_id'],
//       sharing: json['sharing'] != null
//           ? PostSharingModel.fromJson(json['sharing'])
//           : null,
//       likesCount: json['likes_count'],
//       commentsCount: json['comments_count'],
//       sharingsCount: json['sharings_count'],
//       createdAt: json["created_at"] == null
//           ? null
//           : DateTime.parse(json["created_at"]),
//       updatedAt: json["updated_at"] == null
//           ? null
//           : DateTime.parse(json["updated_at"]),
//     );
//   }
// }
