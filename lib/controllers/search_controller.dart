import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SearchUsersController extends GetxController {
  List<User> users = [];
  bool isLoading = false;
  TextEditingController search = TextEditingController();

  Future searchByUsers(String search) async {
    isLoading = true;
    update();
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      final res = await dio.get(
        "${MyMethods.baseUrl}/users/$search",
        options: Options(
          headers: {"Authorization": "Bearer ${box.read("token")}"},
        ),
      );
      if (res.statusCode == 200) {
        List<User> convertedUsers = [];
        for (final user in res.data) {
          convertedUsers.add(User.fromJson(user));
        }
        users.assignAll(convertedUsers);
        update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }
}
