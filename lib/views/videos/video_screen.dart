import 'package:blog_mag/Widgets/vid_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments.toString().split("/").last),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: Get.width,
          height: Get.width * 9 / 16,
          child: VidPlayer(
            path: Get.arguments,
            outoPlay: true,
          ),
        ),
      ),
    );
  }
}
