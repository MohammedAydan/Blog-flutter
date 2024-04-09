import 'package:cloud_firestore/cloud_firestore.dart';

class Msg {
  final String? id;
  final int? userId;
  final int? rUserId;
  final String? message;
  final String? mediaType;
  final String? media;
  final DateTime? readAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Msg({
    this.id,
    this.userId,
    this.rUserId,
    this.message,
    this.mediaType,
    this.media,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Msg.fromJson(Map<String, dynamic> json, {bool cc = false}) {
    if (cc) {
      return Msg(
        id: json['id'],
        userId: json['user_id'],
        rUserId: json['r_user_id'],
        message: json['message'],
        mediaType: json['media_type'],
        media: json['media'],
        readAt:
            json['read_at'] != null ? (DateTime.parse(json['read_at'])) : null,
        createdAt: json['created_at'] != null
            ? (DateTime.parse(json['created_at']))
            : null,
        updatedAt: json['updated_at'] != null
            ? (DateTime.parse(json['updated_at']))
            : null,
      );
    }
    return Msg(
      id: json['id'],
      userId: json['user_id'],
      rUserId: json['r_user_id'],
      message: json['message'],
      mediaType: json['media_type'],
      media: json['media'],
      readAt: json['read_at'] != null
          ? (json['read_at'] as Timestamp).toDate()
          : null,
      createdAt: json['created_at'] != null
          ? (json['created_at'] as Timestamp).toDate()
          : null,
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'r_user_id': rUserId,
      'message': message,
      'media_type': mediaType,
      'media': media,
      'read_at': null,
      'created_at': DateTime.now(),
      'updated_at': DateTime.now(),
    };
  }

  Map<String, dynamic> toFullJson() {
    return {
      'id': id,
      'user_id': userId,
      'r_user_id': rUserId,
      'message': message,
      'media_type': mediaType,
      'media': media,
      'read_at': readAt != null ? (readAt)!.toIso8601String() : null,
      'created_at': createdAt != null ? (createdAt)!.toIso8601String() : null,
      'updated_at': updatedAt != null ? (updatedAt)!.toIso8601String() : null,
    };
  }
}
