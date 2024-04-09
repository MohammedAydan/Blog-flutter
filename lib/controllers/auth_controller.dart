import 'dart:io';

import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/controllers/chats/logic.dart';
import 'package:blog_mag/controllers/home_controller.dart';
import 'package:blog_mag/models/register_model.dart';
import 'package:blog_mag/models/user_model.dart';
import 'package:blog_mag/models/user_request_model.dart';
import 'package:blog_mag/views/auth/login_screen.dart';
import 'package:blog_mag/views/chats/chat_screen.dart';
import 'package:blog_mag/views/no_connection.dart';
import 'package:blog_mag/views/preofile_screen.dart';
import 'package:blog_mag/views/routing.dart';
import 'package:blog_mag/views/show_screen.dart';
import 'package:blog_mag/views/user_profile_screen.dart';
import 'package:dio/dio.dart' as dio_;
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';

class AuthController extends GetMaterialController {
  HomeController? homeController;
  final Map<String, TextEditingController> registerData = {
    'name': TextEditingController(),
    'username': TextEditingController(),
    'email': TextEditingController(),
    'phone': TextEditingController(),
    'age': TextEditingController(),
    'password': TextEditingController(),
    'confirmPassword': TextEditingController(),
  };
  final Map<String, TextEditingController> loginData = {
    'email': TextEditingController(),
    'password': TextEditingController(),
  };
  XFile? img;
  bool initLoading = true;
  bool isLoading = true;
  Dio dio = Dio();
  bool isAuth = false;
  String? token;
  User? user;
  String error = "";
  StreamSubscription? _sub;

  void setLoading(bool loading) {
    isLoading = loading;
    update();
  }

  void setError(String error_) {
    error = error_;
    update();
  }

  Future getUser() async {
    setLoading(true);
    try {
      GetStorage box = GetStorage();
      final res = await dio.get(
        '${MyMethods.baseUrl}/user',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${box.read('token')}',
          },
        ),
      );
      if (res.statusCode == 200) {
        setError("");
        user = User.fromJson(res.data);
        if (user!.deleted!) {
          setError("Your account has been deleted or temporarily suspended");
          box.remove('token');
          return;
        }
        isAuth = true;
        setError("");
        update();
      }
    } catch (e) {
      setError(e.toString().split("]:")[1].split('.')[0]);
    } finally {
      setLoading(false);
      setError("");
    }
  }

  void register() async {
    Register data = Register(
      name: registerData['name']!.text.trim(),
      username: registerData['username']!.text.trim(),
      email: registerData['email']!.text.trim(),
      phone: (registerData['phone']!.text.trim()),
      age: (registerData['age']!.text.trim()),
      img: img,
      password: registerData['password']!.text.trim(),
      confirmPassword: registerData['confirmPassword']!.text.trim(),
    );
    if (data.name!.isEmpty) {
      setError("Name field required");
      return;
    }
    if (data.username!.isEmpty) {
      setError("Username field required");
      return;
    }
    if (data.email!.isEmpty) {
      setError("Email field required");
      return;
    }
    if (data.phone!.isEmpty) {
      setError("Phone field required");
      return;
    }
    if (data.age!.isEmpty) {
      setError("Age field required");
      return;
    }
    if (!(data.img != null)) {
      setError("Img field required");
      return;
    }
    if (data.password!.isEmpty) {
      setError("Password field required");
      return;
    }
    if (data.confirmPassword!.isEmpty) {
      setError("Confirm Password field required");
      return;
    }
    if (data.img == null) {
      setError("Confirm Password field required");
      return;
    }
    if (data.password != data.confirmPassword) {
      setError("Confirm password does not match the password");
      return;
    }
    setLoading(true);
    dio_.FormData formData = dio_.FormData.fromMap({
      "name": data.name,
      "username": data.username,
      "email": data.email,
      "phone": data.phone,
      "age": data.age,
      "img_url": await dio_.MultipartFile.fromFile(data.img!.path),
      "password": data.password,
      "confirm_password": data.confirmPassword,
    });
    try {
      GetStorage box = GetStorage();
      final res = await dio.post(
        '${MyMethods.baseUrl}/register',
        data: formData,
        options: Options(
          contentType: "multipart/form-data",
          headers: {
            'Authorization': 'Bearer ${box.read('token')}',
          },
        ),
      );
      if (res.statusCode == 200) {
        setError("");
        GetStorage box = GetStorage();
        box.write('token', res.data['access_token']);
        await getUser();
        Get.offNamed(RoutingLayout.routeName);
        if (homeController != null) {
          homeController!.getPosts();
        }
      }
    } catch (e) {
      setError(e.toString().split("]:")[1].split('.')[0]);
    } finally {
      setLoading(false);
    }
  }

  void login() async {
    setLoading(true);
    try {
      final res = await dio.post(
        '${MyMethods.baseUrl}/login',
        data: {
          'email': loginData['email']!.text.trim(),
          'password': loginData['password']!.text.trim(),
        },
      );
      if (res.statusCode == 200) {
        setError("");
        GetStorage box = GetStorage();
        box.write('token', res.data['access_token']);
        await getUser();
        if (user!.deleted!) {
          setError("Your account has been deleted or temporarily suspended");
          box.remove('token');
          return;
        } else {
          Get.offNamed(RoutingLayout.routeName);
          if (homeController != null) {
            homeController!.getPosts();
          }
        }
      }
    } catch (e) {
      setError(e.toString().split("]:")[1].split('.')[0]);
    } finally {
      setLoading(false);
    }
  }

  void logout() async {
    GetStorage box = GetStorage();
    dio.delete(
      '${MyMethods.baseUrl}/logout',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${box.read('token')}',
        },
      ),
    );
    box.remove('token');
    isAuth = false;
    user = null;
    setError("");
    Get.offAllNamed(LoginScreen.routeName);
    update();
  }

  Future<void> ready() async {
    // Initialization logic
    setLoading(true);

    // try {
    //   final isConnection = await InternetConnectionChecker().hasConnection;
    //   if (!isConnection) {
    //     setError("No internet connection");
    //     Get.offAllNamed(NoConnection.routeName);
    //     return;
    //   }
    // } catch (e) {
    //   print(e);
    // }

    final box = GetStorage();
    if (box.read('token') != null) {
      try {
        await getUser();

        if (isAuth && user != null) {
          Get.offNamed(RoutingLayout.routeName);
          await initUniLinks();
          homeController?.getPosts();
          MyMethods.storeFCMData(user?.id.toString() ?? "");
        } else {
          Get.offNamed(LoginScreen.routeName);
        }
      } catch (e) {
        setError(e.toString());
      }
    } else {
      setLoading(false);
      Get.offNamed(LoginScreen.routeName);
    }
  }

  Future<void> initUniLinks() async {
    try {
      final initialUri = await getInitialUri();
      if (initialUri != null) {
        if (initialUri.queryParameters['post'] != null) {
          Get.toNamed(
            ShowScreen.routeName,
            arguments: int.parse(initialUri.queryParameters['post']!),
          );
        } else if (initialUri.queryParameters['profile'] != null) {
          final profileId = int.parse(initialUri.queryParameters['profile']!);
          if (profileId == user!.id) {
            Get.toNamed(ProfileScreen.routeName);
          } else {
            Get.toNamed(
              UserProfileScreen.routeName,
              arguments: profileId,
            );
          }
        } else {
          handleDeepLink(initialUri);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void handleDeepLink(Uri uri) {
    if (uri.path.contains("/profile/")) {
      final profileId = int.parse(uri.path.split("/profile/").last);
      if (profileId == user!.id) {
        Get.toNamed(ProfileScreen.routeName);
      } else {
        Get.toNamed(
          UserProfileScreen.routeName,
          arguments: profileId,
        );
      }
    } else if (uri.path.contains("/post/")) {
      Get.toNamed(
        ShowScreen.routeName,
        arguments: int.parse(uri.path.split("/post/").last),
      );
    } else {
      handleDeepLink2(uri);
    }
  }

  void handleDeepLink2(Uri uri) {
    if (uri.scheme == "blog") {
      switch (uri.host) {
        case "post":
          Get.toNamed(
            ShowScreen.routeName,
            arguments: int.parse(uri.pathSegments[0]),
          );
          break;
        case "profile":
          if (int.parse(uri.pathSegments[0]) == user!.id) {
            Get.toNamed(ProfileScreen.routeName);
          } else {
            Get.toNamed(
              UserProfileScreen.routeName,
              arguments: int.parse(uri.path.split("/profile/").last),
            );
          }
          break;
      }
    }
  }

  fcmL() async {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (event.data['type'] == "chat" && event.data['r_user_id'] != null) {
        ChatLogic.getUser(event.data['r_user_id']).then((UserReq? user) {
          if (user != null) {
            Get.toNamed(
              ChatScreen.routeName,
              arguments: user,
            );
          }
        });
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    homeController = Get.find<HomeController>();
    ready();
    fcmL();
  }

  @override
  void dispose() {
    super.dispose();
    loginData['email']!.dispose();
    loginData['password']!.dispose();
  }
}
