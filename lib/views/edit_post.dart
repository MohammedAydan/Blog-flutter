import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/buttons/primary_button.dart';
import 'package:blog_mag/Widgets/text_input.dart';
import 'package:blog_mag/controllers/home_controller.dart';
import 'package:blog_mag/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPostScreen extends StatelessWidget {
  static const String routeName = "/editPost";
  EditPostScreen({super.key});
  final HomeController homeController = Get.find();
  final PostModel post = Get.arguments as PostModel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: homeController,
      builder: (controller) {
        homeController.setEditPost(post);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit post"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  TextInput(
                    label: "Enter title",
                    controller: controller.titlePost,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.bodyPost,
                    maxLength: 5000,
                    maxLines: 12,
                    minLines: 2,
                    decoration: const InputDecoration(
                      counterStyle: TextStyle(
                        color: MyMethods.colorText2,
                      ),
                      label: Text(
                        "Enter body",
                        style: TextStyle(color: MyMethods.colorText2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            height: 80,
            decoration: const BoxDecoration(
              color: MyMethods.bgColor2,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    text: "Update post",
                    width: double.infinity,
                    onPressed: () => controller.updatePost(post.id!),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
