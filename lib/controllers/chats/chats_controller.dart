import 'dart:convert';

import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/controllers/auth_controller.dart';
import 'package:blog_mag/controllers/chats/logic.dart';
import 'package:blog_mag/models/user_request_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatsController extends GetxController {
  List<FullUserRequest> friends = [];
  bool isLoading = false;
  final AuthController _authController = Get.find();
  bool isAppOpen = true;

  Future<void> getFriends() async {
    isLoading = true;
    update();
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      final res = await dio.get(
        "${MyMethods.baseUrl}/friends",
        options: Options(
          headers: {
            "Authorization": "Bearer ${box.read("token")}",
          },
        ),
      );
      if (res.statusCode == 200) {
        if (res.data != null) {
          box.write("friends", jsonEncode(res.data));
          List<dynamic> responseData = res.data;
          friends =
              responseData.map((e) => FullUserRequest.fromJson(e)).toList();
          update();
        }
        update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  void initFriends() {
    GetStorage box = GetStorage();
    final fs = box.read("friends");
    if (fs != null) {
      List friends_ = jsonDecode(fs);
      friends = friends_.map((e) => FullUserRequest.fromJson(e)).toList();
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    initFriends();
    getFriends();
    if (_authController.user != null) {
      SystemChannels.lifecycle.setMessageHandler((message) {
        if (message.toString().contains("inactive")) {
          isAppOpen = false;
          update();
          ChatLogic.setStatus(_authController.user!.id!, false);
        }
        if (message.toString().contains("resumed")) {
          isAppOpen = true;
          update();
          ChatLogic.setStatus(_authController.user!.id!, true);
        }
        return Future.value(message);
      });
    }
  }
}
