import 'dart:io';

import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/text_input.dart';
import 'package:blog_mag/controllers/chats/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatBottomNavBar extends StatelessWidget {
  const ChatBottomNavBar({
    super.key,
    required this.controller,
  });

  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (controller.image != null) ...[
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: MyMethods.bgColor2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.file(
                  File(controller.image!.path),
                  height: 200,
                  width: double.infinity,
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    controller.image = null;
                    controller.update();
                  },
                ),
              ),
            ],
          ),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          width: double.infinity,
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            // color: MyMethods.bgColor2,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextInput(
                  height: 50,
                  borderRadius: BorderRadius.circular(30),
                  label: "Enter your message",
                  controller: controller.textEditingController,
                  onChanged: (value) => controller.message = value,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 0),
                alignment: Alignment.center,
                transformAlignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MyMethods.bgColor2,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                  onPressed: () => selectMedia(context),
                ),
              ),
              if (controller.image != null ||
                  controller.message.isNotEmpty) ...[
                if (controller.isLoading) ...[
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.only(left: 5, right: 0),
                    alignment: Alignment.center,
                    transformAlignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: MyMethods.bgColor2,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const CircularProgressIndicator(),
                  ),
                ] else ...[
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.only(left: 5, right: 0),
                    alignment: Alignment.center,
                    transformAlignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: MyMethods.bgColor2,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: () {
                        controller.sendMessage();
                      },
                      icon: const Icon(Icons.send, color: MyMethods.blueColor2),
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ],
    );
  }

  selectMedia(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: MyMethods.bgColor,
      elevation: 0,
      enableDrag: true,
      showDragHandle: true,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () async {
              Get.back();
              ImagePicker picker = ImagePicker();
              XFile? file = await picker.pickImage(
                source: ImageSource.camera,
              );
              controller.image = file;
              controller.update();
            },
            iconColor: Colors.white,
            textColor: MyMethods.colorText1,
            title: const Text("Camera"),
            leading: const CircleAvatar(
              radius: 20,
              backgroundColor: MyMethods.bgColor2,
              child: Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            onTap: () async {
              Get.back();
              ImagePicker picker = ImagePicker();
              XFile? file = await picker.pickImage(
                source: ImageSource.gallery,
              );
              controller.image = file;
              controller.update();
            },
            iconColor: Colors.white,
            textColor: MyMethods.colorText1,
            title: const Text("Gallery"),
            leading: const CircleAvatar(
              radius: 20,
              backgroundColor: MyMethods.bgColor2,
              child: Icon(
                Icons.image_rounded,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
