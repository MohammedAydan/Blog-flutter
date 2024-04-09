import 'dart:io';

import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/post/post.dart';
import 'package:blog_mag/Widgets/post/splash_post.dart';
import 'package:blog_mag/controllers/bottom_nav_controller.dart';
import 'package:blog_mag/controllers/home_controller.dart';
import 'package:blog_mag/models/post_model.dart';
import 'package:blog_mag/views/add_post.dart';
import 'package:blog_mag/views/chats/chats_screen.dart';
import 'package:blog_mag/views/requests_screen.dart';
import 'package:blog_mag/views/routing.dart';
import 'package:blog_mag/views/videos/home_videos_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  HomeScreen({super.key});

  final HomeController homeController = Get.find();
  final BottomNavController bottomNavController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog"),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(ChatsScreen.routeName);
            },
            icon: const Icon(Icons.chat_rounded),
          ),
          if (homeController.authController != null &&
              homeController.authController!.user != null &&
              homeController.authController!.user!.premissions!
                  .contains("admin")) ...[
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: MyMethods.bgColor,
                  showDragHandle: true,
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        onTap: () {
                          Get.back();
                          Get.toNamed(RoutingLayout.routeName);
                        },
                        trailing: const Icon(Icons.check),
                        iconColor: Colors.white,
                        textColor: MyMethods.colorText1,
                        title: const Text("Blog app"),
                        leading: const CircleAvatar(
                          radius: 20,
                          backgroundColor: MyMethods.bgColor2,
                          child: Icon(
                            FontAwesome.share,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (Platform.isAndroid) ...[
                        ListTile(
                          onTap: () {
                            Get.back();
                            Get.to(() => HomeVideosScreen());
                          },
                          iconColor: Colors.white,
                          textColor: MyMethods.colorText1,
                          title: const Text("Video app"),
                          leading: const CircleAvatar(
                            radius: 20,
                            backgroundColor: MyMethods.bgColor2,
                            child: Icon(
                              Icons.video_collection_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                      ListTile(
                        onTap: () => {},
                        iconColor: Colors.white,
                        textColor: MyMethods.colorText1,
                        title: const Text("Admin panel"),
                        leading: const CircleAvatar(
                          radius: 20,
                          backgroundColor: MyMethods.bgColor2,
                          child: Icon(
                            Icons.admin_panel_settings_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () => {},
                        iconColor: Colors.white,
                        textColor: MyMethods.colorText1,
                        title: const Text("Audio app"),
                        leading: const CircleAvatar(
                          radius: 20,
                          backgroundColor: MyMethods.bgColor2,
                          child: Icon(
                            Icons.audiotrack_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.apps_rounded,
              ),
            ),
          ],
          // if (Platform.isAndroid) ...[
          //   IconButton(
          //     onPressed: () {
          //       Get.to(() => HomeVideosScreen());
          //     },
          //     icon: const Icon(
          //       Icons.video_collection,
          //     ),
          //   ),
          // ],
          IconButton(
            onPressed: () {
              Get.toNamed(RequestsScreen.routeName);
            },
            icon: const Icon(FontAwesome.user_plus),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyMethods.bgColor2,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: MyMethods.borderColor, width: 1),
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {
          Get.toNamed(AddPostScreen.routeName);
          // homeController.addPost();
        },
        child: const Icon(Icons.add, color: MyMethods.colorText1),
      ),
      //
      //
      body: GetBuilder<HomeController>(builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return RefreshIndicator(
          color: MyMethods.colorText1,
          backgroundColor: MyMethods.bgColor2,
          onRefresh: () async => await homeController.refreshGetPosts(),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  width: 1,
                  color: MyMethods.borderColor,
                ),
              ),
            ),
            child: ListView(
              controller: controller.scrollController,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) {
                    PostModel post = controller.posts[index];
                    return Post(post: post);
                  },
                ),
                if (controller.isLoadingPosts) ...[
                  const SplashPost(),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}
