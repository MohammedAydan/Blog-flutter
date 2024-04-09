import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/controllers/videos/home_videos_controller.dart';
import 'package:blog_mag/views/videos/show_videos_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeVideosScreen extends StatelessWidget {
  HomeVideosScreen({super.key});
  final HomeVideosController homeVideosController =
      Get.put(HomeVideosController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: homeVideosController,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Videos"),
            centerTitle: true,
          ),
          body: controller.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.premissionError
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              shadowColor: MyMethods.bgColor2,
                              foregroundColor: MyMethods.bgColor2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: controller.sendPremission,
                            child: const Center(
                              child: Text(
                                "Premission not granted, tap to try again",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const Center(
                            child: Text(
                              "May require manual premission from settings",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.categorys.length,
                      itemBuilder: (context, index) {
                        String p = controller.categorys[index];
                        return ListTile(
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          title: Text(p),
                          leading: const Icon(Icons.video_collection),
                          onTap: () {
                            Get.to(() => ShowVideosScreen(), arguments: p);
                          },
                        );
                      },
                    ),
        );
      },
    );
  }
}
