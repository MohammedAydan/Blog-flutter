import 'dart:io';

import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/models/msg_model.dart';
import 'package:blog_mag/models/status_user_model.dart';
import 'package:blog_mag/models/user_model.dart';
import 'package:blog_mag/models/user_request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ChatLogic {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference statusCollection =
      _firestore.collection('status');
  static final CollectionReference chatsCollection =
      _firestore.collection('chats');

  static Future<void> setStatus(int userId, bool status) async {
    await statusCollection.doc(userId.toString()).set({
      'user_id': userId,
      'status': status,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  static Stream<StatusUser?> getStatusStream(int userId) {
    return statusCollection
        .doc(userId.toString())
        .snapshots()
        .map((statusSnapshot) {
      if (statusSnapshot.exists) {
        final data = statusSnapshot.data() as Map<String, dynamic>;
        return StatusUser.fromJson(data);
      } else {
        return null;
      }
    });
  }

  static Future<void> sendMessage(Msg msg) async {
    await chatsCollection
        .doc(getChatId(msg.userId!, msg.rUserId!))
        .collection("messages")
        .doc(msg.id)
        .set(msg.toJson());
  }

  static Stream<QuerySnapshot<Object?>> getMessages(
    int userId,
    int rUserId,
  ) {
    return chatsCollection
        .doc(getChatId(userId, rUserId))
        .collection("messages")
        .orderBy('created_at', descending: true)
        .limit(60)
        .snapshots();
  }

  static List<Msg> extractMessages(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Msg.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  static String getChatId(int userId, int rUserId) {
    if (userId.hashCode <= rUserId.hashCode) {
      return '$userId-$rUserId';
    } else {
      return '$rUserId-$userId';
    }
  }

  static Future updateReadMessage(Msg msg) async {
    await chatsCollection
        .doc(getChatId(msg.userId!, msg.rUserId!))
        .collection("messages")
        .doc(msg.id)
        .update({
      "read_at": DateTime.now(),
    });
  }

  static String getFormattedDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    // Formatting date
    if (diff.inDays > 0) {
      return DateFormat('dd/MM/yyyy hh:mm a').format(date);
      // return DateFormat('dd/MM/yyyy').format(date);
    }
    // Formatting time
    else {
      return DateFormat('hh:mm a').format(date);
    }
  }

  static Future<void> deleteMessage(Msg msg) async {
    await chatsCollection
        .doc(getChatId(msg.userId!, msg.rUserId!))
        .collection("messages")
        .doc(msg.id)
        .delete();
  }

  static Future<void> deleteChat(int userId, int rUserId) async {
    await chatsCollection.doc(getChatId(userId, rUserId)).delete();
  }

  static Future<void> deleteAllMessages(int userId, int rUserId) async {
    final chatId = getChatId(userId, rUserId);
    final messages =
        await chatsCollection.doc(chatId).collection("messages").get();
    for (final message in messages.docs) {
      await message.reference.delete();
    }
  }

  static Future<void> deleteAllChats(int userId) async {
    final chats = await chatsCollection.get();
    for (final chat in chats.docs) {
      if (chat.id.contains(userId.toString())) {
        await chat.reference.delete();
      }
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
    int userId,
    int rUserId,
  ) {
    return chatsCollection
        .doc(getChatId(userId, rUserId))
        .collection("messages")
        .orderBy("created_at", descending: true)
        .limit(1)
        .snapshots();
  }

  static Future<UserReq?> getUser(id) async {
    GetStorage box = GetStorage();
    Dio dio = Dio();
    final res = await dio.get(
      "${MyMethods.baseUrl}/user/$id",
      options: Options(
        headers: {
          "Authorization": "Bearer ${box.read("token")}",
        },
      ),
    );
    if (res.statusCode == 200) {
      return UserReq.fromJson(res.data);
    }
    return null;
  }

  static Future<String?> uploadImage(XFile file) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String fileNameOnly = file.name.split(".").first;
    String fileExtension = file.name.split(".").last;
    String random = DateTime.now().microsecondsSinceEpoch.toString();
    String fileName = "$random-$fileNameOnly.$fileExtension";
    final ref = storage.ref().child("chat/images/$fileName");
    await ref.putFile(
      File(file.path),
      SettableMetadata(
        contentType: "image/*",
      ),
    );

    return await ref.getDownloadURL();
  }
}
