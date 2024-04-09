import 'dart:io';

import 'package:blog_mag/Widgets/buttons/outlined_button.dart';
import 'package:blog_mag/Widgets/buttons/primary_button.dart';
import 'package:blog_mag/Widgets/text_input.dart';
import 'package:blog_mag/controllers/auth_controller.dart';
import 'package:blog_mag/views/auth/register_screen.dart';
import 'package:blog_mag/views/videos/home_videos_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  LoginScreen({super.key});

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    final arguments = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: authController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Login Screen',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    if (controller.error != "") ...[
                      Text(
                        controller.error,
                        style: const TextStyle(color: Colors.red),
                      )
                    ],
                    if (arguments != "" && arguments != null) ...[
                      Text(
                        arguments.toString(),
                        style: const TextStyle(color: Colors.red),
                      )
                    ],
                    const SizedBox(height: 10),
                    TextInput(
                      label: 'Enter email',
                      controller: controller.loginData['email'],
                    ),
                    const SizedBox(height: 10),
                    TextInput(
                      label: 'Enter password',
                      controller: controller.loginData['password'],
                    ),
                    const SizedBox(height: 30),
                    controller.isLoading
                        ? const CircularProgressIndicator()
                        : PrimaryButton(
                            text: "Login",
                            width: double.infinity,
                            onPressed: () {
                              focusNode.unfocus();
                              controller.login();
                            },
                          ),
                    const SizedBox(height: 10),
                    MyOutlinedButton(
                      width: double.infinity,
                      text: "Register now",
                      onPressed: () => Get.toNamed(RegisterScreen.routeName),
                    ),
                    if (Platform.isAndroid) ...[
                      const SizedBox(height: 20),
                      MyOutlinedButton(
                        width: double.infinity,
                        text: "Open Video Player",
                        onPressed: () => Get.to(() => HomeVideosScreen()),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
