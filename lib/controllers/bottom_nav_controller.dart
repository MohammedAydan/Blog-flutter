import 'package:get/get.dart';

class BottomNavController extends GetxController {
  int currentIndex = 0;

  void selectScreen(int index) {
    currentIndex = index;
    update();
  }
}
