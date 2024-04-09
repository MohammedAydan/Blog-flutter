import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/buttons/danger_button.dart';
import 'package:blog_mag/controllers/auth_controller.dart';
import 'package:blog_mag/views/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<AuthController>(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(SettingsScreen.routeName);
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          body: ListView(
            children: [
              const SizedBox(height: 30),
              CircleAvatar(
                backgroundColor: MyMethods.bgColor2,
                radius: 100,
                backgroundImage: controller.user != null
                    ? controller.user!.imgUrl != null
                        ? NetworkImage(
                            "${MyMethods.mediaAccountsPath}/${controller.user!.imgUrl}",
                          )
                        : null
                    : null,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  const Text("Friends"),
                  Text("${controller.user!.name}"),
                  Text("@${controller.user!.username}"),
                ],
              ),
            ],
          ),
          bottomNavigationBar: Container(
            width: double.infinity,
            height: 95,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: MyMethods.bgColor2,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            child: DangerButton(
              text: "Logout",
              onPressed: () {
                controller.logout();
              },
            ),
          ),
        );
      },
    );
  }
}
