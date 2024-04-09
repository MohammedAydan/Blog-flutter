import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/user_avater.dart';
import 'package:blog_mag/controllers/auth_controller.dart';
import 'package:blog_mag/controllers/bottom_nav_controller.dart';
import 'package:blog_mag/controllers/home_controller.dart';
import 'package:blog_mag/models/post_model.dart';
import 'package:blog_mag/views/edit_post.dart';
import 'package:blog_mag/views/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostHeader extends StatelessWidget {
  PostHeader({super.key, required this.post});

  final PostModel post;
  final AuthController authController = Get.find();
  final BottomNavController bottomNavController = Get.find();
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (authController.user!.id == post.owner!.id) {
                bottomNavController.selectScreen(2);
              } else {
                Get.toNamed(
                  UserProfileScreen.routeName,
                  arguments: post.owner!.id,
                );
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserAvater(
                  imgUrl:
                      "${MyMethods.mediaAccountsPath}/${post.owner!.imgUrl}",
                  verified: post.owner!.accountConfirmation,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.owner!.name!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (authController.user!.id == post.owner!.id) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: MyMethods.bgColor2,
                  child: const Icon(
                    Icons.more_horiz,
                    color: MyMethods.colorText2,
                  ),
                  // child: ,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        onTap: () {
                          Get.toNamed(
                            EditPostScreen.routeName,
                            arguments: post,
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () => homeController.deletePost(post.id!),
                        child: Container(
                          decoration: const BoxDecoration(),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delete",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                ),
                // IconButton(
                //   icon: const Icon(
                //     Icons.more_horiz,
                //     color: MyMethods.colorText1,
                //   ),
                //   onPressed: () {
                //   },
                // ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
