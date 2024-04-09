import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/controllers/home_controller.dart';
import 'package:blog_mag/models/comment_model.dart';
import 'package:blog_mag/models/post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ShowController extends GetxController {
  HomeController? homeController;
  int id = Get.arguments;
  bool isLoading = false;
  bool isLoadingComments = false;
  PostModel? post;
  List<CommentModel> comments = [];
  TextEditingController commentTextEditController = TextEditingController();
  String comment = "";

  void getPost() async {
    isLoading = true;
    update();
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      final res = await dio.get("${MyMethods.baseUrl}/posts/$id",
          options: Options(
            headers: {
              "Authorization": "Bearer ${box.read("token")}",
            },
          ));
      if (res.statusCode == 200) {
        post = PostModel.fromJson(res.data);
        isLoading = false;
        update();
        getComments();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  void getComments() async {
    isLoading = true;
    update();
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      final res = await dio.get("${MyMethods.baseUrl}/comments/$id",
          options: Options(
            headers: {
              "Authorization": "Bearer ${box.read("token")}",
            },
          ));
      if (res.statusCode == 200) {
        List<CommentModel> convertedComments = [];
        for (final comment in res.data) {
          // print(comment);
          convertedComments.add(CommentModel.fromJson(comment));
        }
        comments = convertedComments;
        update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  void setCommentText(e) {
    comment = e;
    update();
  }

  Future addComment() async {
    if (comment.isNotEmpty) {
      final res = await MyMethods.post.addComment(comment, id);
      setCommentText("");
      commentTextEditController.clear();
      if (res != null) {
        comments.add(res);
        post!.commentsCount = post!.commentsCount! + 1;
        int postIndex = homeController!.posts.indexWhere((p) => p.id == id);

        if (postIndex != -1) {
          PostModel uPost = homeController!.posts[postIndex];
          if (uPost.commentsCount! > 0) {
            uPost.commentsCount = uPost.commentsCount! + 1;
          }

          homeController!.posts[postIndex] = uPost;
          homeController!.update();
        }
        update();
      }
    }
  }

  Future<void> removeComment(int id) async {
    await MyMethods.post.removeComment(id);

    comments.removeWhere((c) => c.id == id);

    if (post!.commentsCount! > 0) {
      post!.commentsCount = post!.commentsCount! - 1;
    }

    int postIndex = homeController!.posts.indexWhere((p) => p.id == id);

    if (postIndex != -1) {
      PostModel uPost = homeController!.posts[postIndex];
      if (uPost.commentsCount! > 0) {
        uPost.commentsCount = uPost.commentsCount! - 1;
      }

      homeController!.posts[postIndex] = uPost;
      homeController!.update();
    }

    update();
  }

  Future<void> addOrRemoveLike(int id) async {
    post!.isLikeExists = !post!.isLikeExists!;

    if (post!.isLikeExists!) {
      MyMethods.post.addLike(id);
    } else {
      MyMethods.post.removeLike(id);
    }

    post!.likesCount =
        post!.isLikeExists! ? post!.likesCount! + 1 : post!.likesCount! - 1;

    int postIndex = homeController!.posts.indexWhere((p) => p.id == id);
    PostModel uPost = homeController!.posts[postIndex];

    uPost.isLikeExists = post!.isLikeExists;
    uPost.likesCount = post!.likesCount;

    homeController!.posts[postIndex] = uPost;
    homeController!.update();
    update();
  }

  @override
  void onReady() {
    super.onReady();
    homeController = Get.find<HomeController>();
    getPost();
  }

  @override
  void dispose() {
    super.dispose();
    commentTextEditController.dispose();
  }
}
