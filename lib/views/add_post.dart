import 'dart:io';

import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/buttons/outlined_button.dart';
import 'package:blog_mag/Widgets/buttons/primary_button.dart';
import 'package:blog_mag/Widgets/text_input.dart';
import 'package:blog_mag/Widgets/vid_player.dart';
import 'package:blog_mag/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatelessWidget {
  static const String routeName = "/addPost";
  AddPostScreen({super.key});
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: homeController,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Add new post"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
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
                    if (controller.mediaPost != null) ...[
                      if (MyMethods.getFileType(controller.mediaPost!.name) ==
                          "image") ...[
                        Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(controller.mediaPost!.path),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: IconButton(
                                color: Colors.red,
                                onPressed: () {
                                  controller.mediaPost = null;
                                  controller.update();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (MyMethods.getFileType(controller.mediaPost!.name) ==
                          "video") ...[
                        Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child:
                                    VidPlayer(path: controller.mediaPost!.path),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: IconButton(
                                color: Colors.red,
                                onPressed: () {
                                  controller.mediaPost = null;
                                  controller.update();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (MyMethods.getFileType(controller.mediaPost!.name) ==
                          "audio") ...[
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 55),
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: MyOutlinedButton(
                                  text: controller.mediaPost!.name,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: IconButton(
                                color: Colors.red,
                                onPressed: () {
                                  controller.mediaPost = null;
                                  controller.update();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (MyMethods.getFileType(controller.mediaPost!.name) ==
                          "application") ...[
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 55),
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: MyOutlinedButton(
                                  text: controller.mediaPost!.name,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: IconButton(
                                color: Colors.red,
                                onPressed: () {
                                  controller.mediaPost = null;
                                  controller.update();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 20),
                    ],
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
                      text: "Add",
                      width: double.infinity,
                      onPressed: controller.storePost,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: MyMethods.blueColor1,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      color: MyMethods.colorText1,
                      onPressed: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? file = await picker.pickMedia();
                        if (file != null) {
                          controller.mediaPost = file;
                          controller.update();
                        }
                      },
                      icon: const Icon(FontAwesome.file_image_o),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
