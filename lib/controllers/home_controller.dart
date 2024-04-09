import 'dart:async';

import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/buttons/primary_button.dart';
import 'package:blog_mag/Widgets/text_input.dart';
import 'package:blog_mag/controllers/auth_controller.dart';
import 'package:blog_mag/models/post_model.dart';
import 'package:dio/dio.dart' as dio_;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  Dio dio = Dio();
  List<PostModel> posts = [];
  bool isLoading = false;
  bool isLoadingPosts = false;
  bool isLoadingStorePost = false;
  String error = "";
  int limit = 5;
  int page = 1;
  AuthController? authController;
  TextEditingController titlePost = TextEditingController();
  TextEditingController bodyPost = TextEditingController();
  XFile? mediaPost;
  double prossessCount = 0.0;
  ScrollController scrollController = ScrollController();

  void setLoading(bool loading) {
    isLoading = loading;
    update();
  }

  Future getPosts() async {
    setLoading(true);
    try {
      posts.clear();
      page = 1;
      update();
      await fetchPosts();
    } catch (e) {
      print(e);
    } finally {
      setLoading(false);
    }
  }

  Future fetchPosts({int page = 1}) async {
    isLoadingPosts = true;
    update();
    try {
      GetStorage box = GetStorage();
      final res = await dio.get(
        "${MyMethods.baseUrl}/posts/$limit/$page",
        options: Options(
          headers: {
            'Authorization': "Bearer ${box.read("token")}",
          },
        ),
      );
      if (res.statusCode == 200) {
        List<PostModel> convertPosts = [];
        for (final postData in res.data) {
          convertPosts.add(PostModel.fromJson(postData));
        }
        posts.addAll(convertPosts);
      }
    } catch (e) {
      error = e.toString().split("]:")[1].split(".")[0];
    } finally {
      isLoadingPosts = false;
      update();
    }
  }

  Future refreshGetPosts() async {
    page = 1;
    update();
    await getPosts();
  }

  Future sharingPostDialog(int postId) async {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: MyMethods.bgColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Sharing post"),
              const SizedBox(height: 20),
              TextInput(
                label: "Enter title",
                controller: titlePost,
              ),
              const SizedBox(height: 10),
              TextInput(
                label: "Enter body",
                controller: bodyPost,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: MyMethods.borderColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("POST ID: $postId"),
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                text: "Sharing post",
                width: double.infinity,
                onPressed: () => storeSharingPost(postId),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future storeSharingPost(int postId) async {
    MyMethods.showLoading(
      showLinerPro: true,
      value: prossessCount,
    );
    // return;
    isLoadingStorePost = true;
    update();
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      dio_.FormData formData = dio_.FormData.fromMap(
        {
          "title": titlePost.text.trim(),
          "body": bodyPost.text.trim(),
          "sharing_post_id": postId,
        },
      );
      final res = await dio.post(
        "${MyMethods.baseUrl}/posts",
        data: formData,
        options: Options(
          contentType: "multipart/form-data",
          headers: {
            "Authorization": "Bearer ${box.read("token")}",
          },
        ),
        onSendProgress: (count, total) {
          prossessCount = (count / total).toDouble();
          update();
        },
      );

      prossessCount = 0.0;
      update();
      posts.add(PostModel.fromJson(res.data));
      posts.sort((a, b) => b.id! - a.id!);
      update();
    } catch (e) {
      print(e);
    } finally {
      titlePost.clear();
      bodyPost.clear();
      mediaPost = null;
      isLoadingStorePost = false;
      prossessCount = 0.0;
      update();
      Get.back();
      Get.back();
    }
  }

  Future storePost() async {
    MyMethods.showLoading(
      showLinerPro: true,
      value: prossessCount,
    );
    // return;
    print(mediaPost?.path);
    isLoadingStorePost = true;
    update();
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      dio_.FormData formData = dio_.FormData.fromMap(
        {
          "title": titlePost.text.trim(),
          "body": bodyPost.text.trim(),
          "media_type":
              mediaPost != null ? MyMethods.getFileType(mediaPost!.name) : null,
          "media_url": mediaPost != null
              ? await dio_.MultipartFile.fromFile(mediaPost!.path)
              : null,
        },
      );
      final res = await dio.post(
        "${MyMethods.baseUrl}/posts",
        data: formData,
        options: Options(
          contentType: "multipart/form-data",
          headers: {
            "Authorization": "Bearer ${box.read("token")}",
          },
        ),
        onSendProgress: (count, total) {
          prossessCount = (count / total).toDouble();
          update();
        },
      );

      prossessCount = 0.0;
      update();
      posts.add(PostModel.fromJson(res.data));
      posts.sort((a, b) => b.id! - a.id!);
      update();
    } catch (e) {
      print(e);
    } finally {
      titlePost.clear();
      bodyPost.clear();
      mediaPost = null;
      isLoadingStorePost = false;
      prossessCount = 0.0;
      update();
      Get.back();
      Get.back();
    }
  }

  void setEditPost(PostModel post) {
    titlePost.text = post.title ?? "";
    bodyPost.text = post.body ?? "";
    // update();
  }

  Future<void> updatePost(int postId) async {
    MyMethods.showLoading();
    isLoadingStorePost = true;
    update();

    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      Map<String, dynamic> formData = {
        "title": titlePost.text.trim(),
        "body": bodyPost.text.trim(),
      };

      final res = await dio.put(
        "${MyMethods.baseUrl}/posts/$postId",
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer ${box.read("token")}",
          },
        ),
        onSendProgress: (count, total) {
          prossessCount = (count / total).toDouble();
          update();
        },
      );

      prossessCount = 0.0;
      update();

      // Check if the update was successful before updating locally
      if (res.statusCode == 200) {
        int indexPost = posts.indexWhere((p) => p.id! == postId);
        if (indexPost != -1) {
          PostModel post = posts[indexPost];
          post.title = formData["title"];
          post.body = formData["body"];
          posts[indexPost] = post;
          update();
        }
      } else {
        print("Post update failed. Status code: ${res.statusCode}");
      }
      getPosts();
    } catch (e) {
      print(e);
    } finally {
      titlePost.clear();
      bodyPost.clear();
      mediaPost = null;
      isLoadingStorePost = false;
      prossessCount = 0.0;
      update();
      Get.back();
      Get.back();
    }
  }

  Future deletePost(int postId) async {
    MyMethods.showLoading();
    // return;
    isLoadingStorePost = true;
    update();
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      final res = await dio.delete(
        "${MyMethods.baseUrl}/posts/$postId",
        options: Options(
          contentType: "multipart/form-data",
          headers: {
            "Authorization": "Bearer ${box.read("token")}",
          },
        ),
      );
      prossessCount = 0.0;
      update();
      posts.removeWhere((p) => p.id == postId);
      posts.sort((a, b) => b.id! - a.id!);
      update();
    } catch (e) {
      print(e);
    } finally {
      titlePost.clear();
      bodyPost.clear();
      mediaPost = null;
      isLoadingStorePost = false;
      prossessCount = 0.0;
      Get.back();
      update();
    }
  }

  Future addOrRemoveLike(int id) async {
    int post = posts.indexWhere((p) => p.id == id);
    PostModel updatedPost = posts[post];
    updatedPost.isLikeExists = !updatedPost.isLikeExists!;
    if (updatedPost.isLikeExists!) {
      MyMethods.post.addLike(id);
    } else {
      MyMethods.post.removeLike(id);
    }
    updatedPost.likesCount = updatedPost.isLikeExists!
        ? updatedPost.likesCount! + 1
        : updatedPost.likesCount! - 1;
    posts[post] = updatedPost;
    update();
  }

  void loadMore() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print("..............................scrolling");
      page = page + 1;
      update();
      fetchPosts(page: page);
    }
  }

  @override
  void onReady() {
    super.onReady();
    authController = Get.find<AuthController>();

    if (authController != null &&
        !authController!.isLoading &&
        authController!.user != null) {
      getPosts();
    }

    scrollController.addListener(loadMore);
  }
}
