import 'dart:io';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ShowVideosController extends GetxController {
  List<String> videos = [];
  bool loading = false;
  bool premissionError = false;
  final arguments = Get.arguments;

  initVideoPaths() async {
    loading = true;
    update();
    if (arguments == null) {
      sendPremission();
      loading = false;
      update();
      return;
    }
    final vs = await listVideos(Directory('/storage/emulated/0/$arguments/'));
    List<String> temp = [];

    for (var e in vs) {
      if (e.contains("/0/Android/") == false) {
        temp.add(e);
      }
    }

    videos.assignAll(temp);
    loading = false;
    update();
  }

  sendPremission() async {
    PermissionStatus res = await Permission.storage.request();
    if (res.isGranted == true) {
      premissionError = false;
      loading = true;
      update();

      initVideoPaths();
    }
  }

  Future<List<String>> listVideos(Directory dir) async {
    List<String> videoPaths = [];

    try {
      var files = dir.listSync(recursive: true);

      for (var file in files) {
        if (file is File && isVideoFile(file.path)) {
          videoPaths.add(file.path);
        }
      }
    } catch (e) {
      print('Error listing videos: $e');
    }

    return videoPaths;
  }

  bool isVideoFile(String path) {
    return path.toLowerCase().endsWith('.mp4') ||
        path.toLowerCase().endsWith('.mkv') ||
        path.toLowerCase().endsWith('.avi');
  }

  @override
  void onReady() {
    super.onReady();
    if (videos.isEmpty) {
      initVideoPaths();
    }
  }

  @override
  void onInit() {
    super.onInit();
    initVideoPaths();
  }
}
