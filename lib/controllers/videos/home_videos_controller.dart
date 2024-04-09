import 'dart:io';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeVideosController extends GetxController {
  List<String> categorys = [];
  List<String> videos = [];
  bool loading = true;
  bool premissionError = false;

  initVideoPaths() async {
    PermissionStatus res = await Permission.storage.request();
    if (res.isGranted == false) {
      premissionError = true;
      loading = true;
      update();

      return;
    }
    final vs = await listVideos(Directory('/storage/emulated/0/'));
    List<String> temp = [];
    List<String> ps_ = [];

    for (var e in vs) {
      if (e.contains("/0/Android/") == false) {
        temp.add(e);
      }
    }

    for (var e in temp) {
      String p_ = e.split("/0/").last.split("/").first;
      if (ps_.contains(p_) == false) {
        ps_.add(p_);
      }
    }

    videos.assignAll(temp);
    categorys.assignAll(ps_);
    loading = false;
    update();
  }

  sendPremission() async {
    try {
      PermissionStatus res = await Permission.storage.request();
      if (res.isGranted == true) {
        premissionError = false;
        loading = true;
        update();

        initVideoPaths();
      }
    } catch (e) {
      print('Error sending premission: $e');
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
    initVideoPaths();
  }
  // @override
  // void onInit() {
  //   super.onInit();
  //   initVideoPaths();
  // }
}
