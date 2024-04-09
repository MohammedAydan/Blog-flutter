import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final String? phone;
  final int? age;
  final String? imgUrl;
  final DateTime? emailVerifiedAt;
  final bool? accountConfirmation;
  final bool? deleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String>? premissions;

  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.age,
    this.imgUrl,
    this.emailVerifiedAt,
    this.accountConfirmation,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.premissions,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        age: json["age"],
        imgUrl: json["img_url"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        accountConfirmation: json["account_confirmation"] == 1 ? true : false,
        deleted: json["deleted"] == 1 ? true : false,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        premissions: json["premissions"] == null
            ? []
            : List<String>.from(json["premissions"]!.map((x) => x.toString())),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "phone": phone,
        "age": age,
        "img_url": imgUrl,
      };
}
