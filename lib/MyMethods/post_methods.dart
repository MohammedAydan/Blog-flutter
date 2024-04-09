import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/models/comment_model.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class PostMethods {
  Future addLike(int id) async {
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      final res = await dio.post(
        "${MyMethods.baseUrl}/likes",
        data: {
          "post_id": id,
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${box.read("token")}'},
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future removeLike(int id) async {
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();
      final res = await dio.delete(
        "${MyMethods.baseUrl}/likes/$id",
        options: Options(
          headers: {'Authorization': 'Bearer ${box.read("token")}'},
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future addComment(String comment, int id) async {
    try {
      Dio dio = Dio();
      GetStorage box = GetStorage();
      final data = CommentModel(postId: id, comment: comment).toJson();
      final res = await dio.post(
        "${MyMethods.baseUrl}/comments",
        data: data,
        options: Options(
          headers: {"Authorization": "Bearer ${box.read("token")}"},
        ),
      );
      return CommentModel.fromJson(res.data);
    } catch (e) {
      return null;
    }
  }

  Future removeComment(int id) async {
    try {
      Dio dio = Dio();
      GetStorage box = GetStorage();
      final res = await dio.delete(
        "${MyMethods.baseUrl}/comments/$id",
        options: Options(
          headers: {"Authorization": "Bearer ${box.read("token")}"},
        ),
      );
      return true;
    } catch (e) {
      return null;
    }
  }
}
