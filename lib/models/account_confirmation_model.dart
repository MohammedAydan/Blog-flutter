import 'dart:convert';

AccountConfirmationModel accountConfirmationModelFromJson(String str) =>
    AccountConfirmationModel.fromJson(json.decode(str));

String accountConfirmationModelToJson(AccountConfirmationModel data) =>
    json.encode(data.toJson());

class AccountConfirmationModel {
  bool? request;
  int? id;
  int? ownerId;
  String? fullNameInArabic;
  String? fullNameInEnglish;
  String? idCardFront;
  String? idCardBack;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  AccountConfirmationModel({
    this.request,
    this.id,
    this.ownerId,
    this.fullNameInArabic,
    this.fullNameInEnglish,
    this.idCardFront,
    this.idCardBack,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AccountConfirmationModel.fromJson(Map<String, dynamic> json) =>
      AccountConfirmationModel(
        request: json["request"],
        id: json["id"],
        ownerId: json["owner_id"],
        fullNameInArabic: json["full_name_in_arabic"],
        fullNameInEnglish: json["full_name_in_english"],
        idCardFront: json["id_card_front"],
        idCardBack: json["id_card_back"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "full_name_in_arabic": fullNameInArabic,
        "full_name_in_english": fullNameInEnglish,
        "id_card_front": idCardFront,
        "id_card_back": idCardBack,
      };
}
