import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/controllers/auth_controller.dart';
import 'package:blog_mag/controllers/home_controller.dart';
import 'package:blog_mag/controllers/show_controller.dart';
import 'package:blog_mag/models/post_model.dart';
import 'package:blog_mag/views/show_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:get/get.dart';

class PostFooter extends StatelessWidget {
  PostFooter({
    super.key,
    required this.post,
    required this.authController,
    required this.showMode,
    this.showController,
  });

  final PostModel post;
  final bool showMode;
  final AuthController authController;
  final HomeController homeController = Get.find();
  final ShowController? showController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                post.likesCount.toString(),
                style: const TextStyle(color: MyMethods.colorText2),
              ),
              Text(
                post.commentsCount.toString(),
                style: const TextStyle(color: MyMethods.colorText2),
              ),
              Text(
                post.sharingsCount.toString(),
                style: const TextStyle(color: MyMethods.colorText2),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (showMode) {
                    showController!.addOrRemoveLike(post.id!);
                  } else {
                    homeController.addOrRemoveLike(post.id!);
                  }
                },
                icon: Icon(
                  FontAwesome.heart,
                  color: post.isLikeExists! ? Colors.red : MyMethods.colorText1,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.toNamed(ShowScreen.routeName, arguments: post.id);
                },
                icon: const Icon(
                  FontAwesome.comment,
                  color: MyMethods.colorText1,
                ),
              ),
              IconButton(
                onPressed: () {
                  homeController.sharingPostDialog(post.id!);
                },
                icon: const Icon(
                  FontAwesome.share,
                  color: MyMethods.colorText1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
