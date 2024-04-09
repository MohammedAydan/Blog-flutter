import 'package:blog_mag/controllers/auth_controller.dart';
import 'package:blog_mag/controllers/bottom_nav_controller.dart';
import 'package:blog_mag/controllers/home_controller.dart';
import 'package:get/get.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(HomeController());
    Get.put(BottomNavController());
  }
}
