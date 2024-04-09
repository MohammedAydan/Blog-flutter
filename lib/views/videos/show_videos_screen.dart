import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/controllers/videos/show_videos_controller.dart';
import 'package:blog_mag/views/videos/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowVideosScreen extends StatelessWidget {
  ShowVideosScreen({super.key});
  final ShowVideosController showVideosController =
      Get.put(ShowVideosController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: showVideosController,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(Get.arguments),
              centerTitle: true,
            ),
            body: controller.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: controller.videos.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => const VideoScreen(),
                            arguments: controller.videos[index],
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: (Get.width / 2) - 10,
                              height: (Get.width * 9 / 16) - 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: MyMethods.borderColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.video_collection,
                                  size: 50,
                                  color: MyMethods.bgColor2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              controller.videos[index].split("/").last,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          );
        });
  }
}
