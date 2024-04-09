import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/models/user_model.dart';
import 'package:blog_mag/models/user_request_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserProfileController extends GetxController {
  int? id = Get.arguments;
  bool isLoading = false;
  bool isLoadingReq = false;
  User? user;
  UserRequest? userRequest;

  Future getUser() async {
    isLoading = true;
    update();
    try {
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
        user = User.fromJson(res.data);
        update();
        checkRequest();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future checkRequest() async {
    isLoadingReq = true;
    update();
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      final res = await dio.get(
        "${MyMethods.baseUrl}/friends/$id",
        options: Options(
          headers: {
            "Authorization": "Bearer ${box.read("token")}",
          },
        ),
      );
      if (res.statusCode == 200) {
        if (res.data == null) {
          userRequest = null;
        } else {
          userRequest = UserRequest.fromJson(res.data['request']);
        }
        update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingReq = false;
      update();
    }
  }

  Future sendRequest() async {
    isLoadingReq = true;
    update();
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      final res = await dio.post(
        "${MyMethods.baseUrl}/friends",
        data: {
          "user_id": id,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${box.read("token")}",
          },
        ),
      );
      if (res.statusCode == 200) {
        if (res.data == null) {
          userRequest = null;
        } else {
          userRequest = UserRequest.fromJson(res.data['request']);
        }
        update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingReq = false;
      update();
    }
  }

  Future acceptRequest() async {
    isLoadingReq = true;
    update();
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      final res = await dio.put(
        "${MyMethods.baseUrl}/friends/${userRequest!.id}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${box.read("token")}",
          },
        ),
      );
      if (res.statusCode == 200) {
        userRequest!.status = true;
        update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingReq = false;
      update();
    }
  }

  Future cancelRequest() async {
    isLoadingReq = true;
    update();
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      final res = await dio.delete(
        "${MyMethods.baseUrl}/friends/${userRequest!.id}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${box.read("token")}",
          },
        ),
      );
      if (res.statusCode == 200) {
        userRequest = null;
        update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingReq = false;
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
    getUser();
  }
}
