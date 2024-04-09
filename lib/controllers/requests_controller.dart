import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/models/user_request_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RequestsController extends GetxController {
  List<FullUserRequest> requests = [];
  bool isLoading = false;

  Future getRequests() async {
    isLoading = true;
    update();
    try {
      GetStorage box = GetStorage();
      Dio dio = Dio();

      final res = await dio.get(
        "${MyMethods.baseUrl}/friends/requests",
        options: Options(
          headers: {
            "Authorization": "Bearer ${box.read("token")}",
          },
        ),
      );

      if (res.statusCode == 200) {
        List<FullUserRequest> converted = [];
        for (final req in res.data) {
          converted.add(FullUserRequest.fromJson(req));
        }
        requests.assignAll(converted);
        update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getRequests();
  }
}
