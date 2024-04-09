import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/buttons/danger_button.dart';
import 'package:blog_mag/controllers/auth_controller.dart';
import 'package:blog_mag/controllers/show_controller.dart';
import 'package:blog_mag/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Comment extends StatelessWidget {
  Comment({super.key, required this.comment, required this.showController});

  final CommentModel comment;
  final ShowController showController;
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: MyMethods.bgColor2,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          "${MyMethods.mediaAccountsPath}/${comment.user!.imgUrl}",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text("${comment.user!.name}"),
                    ],
                  ),
                  if (authController.user!.id == comment.user!.id) ...[
                    const SizedBox(width: 10),
                    DangerButton(
                      text: "DELETE",
                      onPressed: () =>
                          showController.removeComment(comment.id!),
                      height: 30,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 20),
              Text("${comment.comment}"),
            ],
          ),
        ),
      ],
    );
  }
}
