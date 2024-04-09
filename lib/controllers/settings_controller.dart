import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/controllers/auth_controller.dart';
import 'package:blog_mag/views/auth/login_screen.dart';
import 'package:dio/dio.dart' as dio_;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class SettingsController extends GetxController {
  AuthController? authController;
  bool reqIsDone = false;
  bool reqDone = false;
  bool isLoadingAccountConfirmation = false;
  bool isLoadingEditProfile = false;
  bool isLoadingEditPassword = false;
  bool isLoadingDeleteAccount = false;
  Map<String, dynamic> messages = {
    "updateProfile": null,
    "updatePassword": null,
  };
  Map<String, dynamic> errors = {
    "updateProfile": null,
    "updatePassword": null,
  };
  Map<String, TextEditingController> accountConfirmation = {
    "fullNameAr": TextEditingController(),
    "fullNameEg": TextEditingController(),
  };
  Map<String, TextEditingController> editProfile = {
    "name": TextEditingController(),
    "username": TextEditingController(),
    "email": TextEditingController(),
    "phone": TextEditingController(),
    "age": TextEditingController(),
  };
  Map<String, TextEditingController> editPassword = {
    "password": TextEditingController(),
    "newPassword": TextEditingController(),
    "confirmPassword": TextEditingController(),
  };
  XFile? imgIdf;
  XFile? imgIdb;

  Future isRequest() async {
    isLoadingAccountConfirmation = true;
    update();
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      final res = await dio.get(
        "${MyMethods.baseUrl}/user/account-confirmation",
        options: Options(
          contentType: Headers.multipartFormDataContentType,
          headers: {
            "Authorization": "Bearer ${box.read("token")}",
          },
        ),
      );
      if (res.statusCode == 200) {
        if (res.data['request'] == true || res.data['request'] == 1) {
          if (res.data['status'] == true || res.data['status'] == 1) {
            reqIsDone = true;
            reqDone = true;
            update();
          } else {
            reqIsDone = false;
            reqDone = true;
            update();
          }
        } else {
          reqIsDone = false;
          reqDone = false;
          update();
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingAccountConfirmation = false;
      update();
    }
  }

  Future requestConfirmationAccount() async {
    isLoadingAccountConfirmation = true;
    dio_.FormData data = dio_.FormData.fromMap({
      "fullname_in_arabic": accountConfirmation['fullNameAr']!.text.trim(),
      "fullname_in_english": accountConfirmation['fullNameEg']!.text.trim(),
      "identity_card_front": await dio_.MultipartFile.fromFile(imgIdf!.path),
      "identity_card_back": await dio_.MultipartFile.fromFile(imgIdb!.path),
    });
    update();
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      final res = await dio.post(
        "${MyMethods.baseUrl}/user/account-confirmation",
        data: data,
        options: Options(
          contentType: Headers.multipartFormDataContentType,
          headers: {
            "Authorization": "Bearer ${box.read("token")}",
          },
        ),
      );
      if (res.statusCode == true) {
        if (res.data['request'] == true) {
          reqDone = true;
          update();
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingAccountConfirmation = false;
      update();
    }
  }

  Future updateProfile() async {
    isLoadingEditProfile = true;
    update();

    if (editProfile['name']!.text.trim().isEmpty) {
      errors['updateProfile'] = "Name field required";
      isLoadingEditProfile = false;
      update();
      return;
    }

    if (editProfile['username']!.text.trim().isEmpty) {
      errors['updateProfile'] = "Username field required";
      isLoadingEditProfile = false;
      update();
      return;
    }

    if (editProfile['email']!.text.trim().isEmpty) {
      errors['updateProfile'] = "Email field required";
      isLoadingEditProfile = false;
      update();
      return;
    }

    if (editProfile['age']!.text.trim().isEmpty) {
      errors['updateProfile'] = "Age field required";
      isLoadingEditProfile = false;
      update();
      return;
    }

    final data = {
      "name": editProfile['name']!.text.trim(),
      "username": editProfile['username']!.text.trim(),
      "email": editProfile['email']!.text.trim(),
      "phone": editProfile['phone']!.text.trim(),
      "age": editProfile['age']!.text.trim(),
    };
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      final res = await dio.put(
        "${MyMethods.baseUrl}/user",
        data: data,
        options: Options(
          contentType: Headers.multipartFormDataContentType,
          headers: {
            "Authorization": "Bearer ${box.read("token")}",
          },
        ),
      );
      if (res.statusCode == 200) {
        errors['updateProfile'] = "";
        messages['updateProfile'] = "Update successfully";
        update();
      }
      authController!.getUser();
    } catch (e) {
      print(e);
    } finally {
      isLoadingEditProfile = false;
      update();
    }
  }

  Future updatePassword() async {
    isLoadingEditPassword = true;
    update();

    if (editPassword['password']!.text.trim().isEmpty) {
      print(".................................");
      print(editPassword['password']!.text.trim());
      errors['updatePassword'] = "Password filed required";
      isLoadingEditPassword = false;
      update();
      return;
    }
    if (editPassword['newPassword']!.text.trim().isEmpty) {
      errors['updatePassword'] = "New password filed required";
      isLoadingEditPassword = false;
      update();
      return;
    }

    if (editPassword['newPassword']!.text.trim() !=
        editPassword['confirmPassword']!.text.trim()) {
      errors['updatePassword'] = "Confirm password does not match the password";
      isLoadingEditPassword = false;
      update();
      return;
    }

    final data = {
      "password": editPassword['password']!.text.trim(),
      "new_password": editPassword['newPassword']!.text.trim(),
    };

    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      final res = await dio.put(
        "${MyMethods.baseUrl}/user/password",
        data: data,
        options: Options(
          contentType: Headers.multipartFormDataContentType,
          headers: {
            "Authorization": "Bearer ${box.read("token")}",
          },
        ),
      );
      if (res.statusCode == 200) {
        errors['updatePassword'] = "";
        messages['updatePassword'] = "Update successfully";
        update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingEditPassword = false;
      update();
    }
  }

  Future deleteAccount() async {
    isLoadingDeleteAccount = true;
    update();
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      final res = await dio.delete(
        "${MyMethods.baseUrl}/user",
        options: Options(
          contentType: Headers.multipartFormDataContentType,
          headers: {
            "Authorization": "Bearer ${box.read("token")}",
          },
        ),
      );
      box.remove('token');
      Get.offAllNamed(
        LoginScreen.routeName,
        arguments: "Your account has been deleted",
      );
    } catch (e) {
      print(e);
    } finally {
      isLoadingDeleteAccount = false;
      update();
    }
  }

  @override
  void dispose() {
    super.dispose();
    accountConfirmation.forEach((key, value) => value.dispose());
    editProfile.forEach((key, value) => value.dispose());
    editPassword.forEach((key, value) => value.dispose());
  }

  @override
  void onReady() {
    super.onReady();
    if (authController != null) {
      editProfile['name']!.text = authController!.user!.name!;
      editProfile['username']!.text = authController!.user!.username!;
      editProfile['email']!.text = authController!.user!.email!;
      editProfile['phone']!.text = authController!.user!.phone!;
      editProfile['age']!.text = authController!.user!.age!.toString();
    }
    isRequest();
  }

  @override
  void onInit() {
    super.onInit();
    authController = Get.find<AuthController>();
    update();
  }
}
