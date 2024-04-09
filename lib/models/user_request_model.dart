class UserRequest {
  int? id;
  int? ownerId;
  int? userId;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserRequest({
    this.id,
    this.ownerId,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
        id: json['id'],
        ownerId: json['owner_id'],
        userId: json['user_id'],
        status: json['status'] == 1 ? true : false,
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );
}

class FullUserRequest {
  int? id;
  int? ownerId;
  int? userId;
  UserReq? owner;
  UserReq? user;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  FullUserRequest({
    this.id,
    this.ownerId,
    this.userId,
    this.owner,
    this.user,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory FullUserRequest.fromJson(Map<String, dynamic> json) => FullUserRequest(
        id: json['id'],
        ownerId: json['owner_id'],
        userId: json['user_id'],
        owner: UserReq.fromJson(json['owner']),
        user: UserReq.fromJson(json['user']),
        status: json['status'] == 1 ? true : false,
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );
}

class UserReq {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final String? phone;
  final int? age;
  final String? imgUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserReq({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.age,
    this.imgUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory UserReq.fromJson(Map<String, dynamic> json) => UserReq(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        age: json["age"],
        imgUrl: json["img_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
