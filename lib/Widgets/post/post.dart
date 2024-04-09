import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/post/post_footer.dart';
import 'package:blog_mag/Widgets/post/post_header.dart';
import 'package:blog_mag/Widgets/post/post_media.dart';
import 'package:blog_mag/controllers/auth_controller.dart';
import 'package:blog_mag/controllers/home_controller.dart';
import 'package:blog_mag/controllers/show_controller.dart';
import 'package:blog_mag/models/post_model.dart';
import 'package:blog_mag/views/show_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Post extends StatelessWidget {
  Post({
    super.key,
    required this.post,
    this.fullBorder = false,
    this.showMode = false,
    this.showController,
  });

  final PostModel post;
  final bool fullBorder;
  final bool showMode;
  final ShowController? showController;
  final AuthController authController = Get.find<AuthController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fullBorder
          ? () {
              Get.toNamed(ShowScreen.routeName, arguments: post.id);
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: MyMethods.bgColor,
          border: !fullBorder
              ? const Border.symmetric(
                  horizontal: BorderSide(
                    color: MyMethods.borderColor,
                    width: 1,
                  ),
                )
              : Border.all(
                  color: MyMethods.borderColor,
                  width: 1,
                ),
          borderRadius: fullBorder ? BorderRadius.circular(10) : null,
        ),
        child: Column(
          children: [
            PostHeader(post: post),
            PostMedia(post: post),
            if (fullBorder == false) ...[
              PostFooter(
                showMode: showMode,
                post: post,
                authController: authController,
                showController: showController,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
