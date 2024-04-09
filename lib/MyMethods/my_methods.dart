import 'dart:io';

import 'package:blog_mag/MyMethods/post_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String url1 = "192.168.1.9";
const String url2 = "192.168.1.7";
// const String url0 = "192.168.1.9";
const String url0 = "192.168.1.6";
// const String url0 = "blog-mag.ddns.net";
const String url3 = "192.168.1.12";
const String url4 = "192.168.43.127";

class MyMethods {
  static const Color bgColor = Color(0xff0f172a);
  static const Color bgColor2 = Color(0xff1e293b);
  static const Color borderColor = Color(0xff1e293b);
  static const Color inputColor = Color(0xff1e293b);
  static const Color colorText1 = Color(0xffffffff);
  static const Color colorText2 = Color(0xff9ca3af);
  static const Color blueColor1 = Color(0xff2563eb);
  static const Color blueColor2 = Color(0xff3b82f6);
  static const String baseUrl = 'http://$url0/api/v1';
  static const String mediaPostsPath = "http://$url0/Assets/Posts/";
  static const String mediaAccountsPath = "http://$url0/Assets/Accounts/";

  static PostMethods get post => PostMethods();

  static String? getFileType(String name) {
    switch (name.split(".").last.toLowerCase()) {
      case "jpg" || "jpeg" || "png" || "gif" || "ico" || "heic":
        {
          return "image";
        }
        break;
      case "mp4" || "mov" || "avi" || "mkv" || "ts":
        {
          return "video";
        }
        break;

      case "mp3" || "oga" || "wav" || "aac" || "amr":
        {
          return "audio";
        }
        break;
      default:
        {
          return "application";
        }
        break;
    }
  }

  static showLoading({bool showLinerPro = false, double value = 0}) {
    return Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          if (showLinerPro == true) ...[
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  minHeight: 17,
                  value: value,
                ),
              ),
            ),
          ],
        ],
      ),
      barrierDismissible: false,
    );
  }

  static void storeFCMData(String userId) async {
    FirebaseMessaging fcm = FirebaseMessaging.instance;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("devices")
        .doc(Platform.operatingSystem)
        .set({
      "user_id": userId,
      "fcm_token": await fcm.getToken(),
      "device_os": Platform.operatingSystem,
      "device_os_version": Platform.operatingSystemVersion,
      "created_at": FieldValue.serverTimestamp(),
      "updated_at": FieldValue.serverTimestamp(),
    });
  }

  static Future sendFCMMessage({
    required String title,
    required String body,
    String? topic,
    String? token,
    String? id,
    String? rUserId,
  }) async {
    String server = "https://fcm.googleapis.com/fcm/send";
    String senderId = "419151198841";
    String serverKey =
        "AAAAYZdbunk:APA91bFv8FQY5IDppD8lDzoiPTZVqOZovaWJLC61NMiEyLNrO8eskBteRlLa-uOJ_AjFHeL-yFlIt-VKHvYEchixDK2QN6bc61iCu11r3QK85p0hVFbS9i75uJzrBMnWU9tMNBIyEA-p";
    List<String> tokens = [];

    if (id != null) {
      final res = await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .collection("devices")
          .get();
      List<String> tokens_ =
          res.docs.map((e) => e.get("fcm_token").toString()).toList();
      tokens.addAll(tokens_);
    }

    Dio dio = Dio();
    if ((id != null && tokens.isNotEmpty) || token != null || topic != null) {
      Map<String, dynamic> requestData = {
        "notification": {
          "title": title,
          "body": body,
        },
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "sound": "default",
          "status": "done",
          "message": "Text Message",
          "type": "chat",
          "r_user_id": rUserId,
        },
      };

      if (topic != null) {
        requestData["to"] = "/topics/$topic";
      } else if (token != null) {
        requestData["to"] = token;
      } else if (id != null && tokens.isNotEmpty) {
        requestData["registration_ids"] = tokens;
      }
      try {
        await dio.post(
          server,
          data: requestData,
          options: Options(
            headers: {
              Headers.contentTypeHeader: Headers.jsonContentType,
              "Authorization": "key=$serverKey",
              "project_id": senderId,
            },
          ),
        );
      } catch (e) {
        rethrow;
      }
    }
  }
}
