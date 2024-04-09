import 'package:blog_mag/Widgets/buttons/button_select_file.dart';
import 'package:blog_mag/Widgets/buttons/primary_button.dart';
import 'package:blog_mag/Widgets/text_input.dart';
import 'package:blog_mag/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = '/register';

  RegisterScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: authController,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Register"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Register Screen',
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
                    const SizedBox(height: 10),
                    TextInput(
                      label: 'Enter name',
                      controller: controller.registerData['name'],
                    ),
                    const SizedBox(height: 10),
                    TextInput(
                      label: 'Enter username',
                      controller: controller.registerData['username'],
                    ),
                    const SizedBox(height: 10),
                    TextInput(
                      label: 'Enter email',
                      controller: controller.registerData['email'],
                    ),
                    const SizedBox(height: 10),
                    TextInput(
                      label: 'Enter phone',
                      controller: controller.registerData['phone'],
                    ),
                    const SizedBox(height: 10),
                    TextInput(
                      label: 'Enter age',
                      controller: controller.registerData['age'],
                    ),
                    const SizedBox(height: 10),
                    ButtonSelectFile(
                      onPressed: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? img = await picker.pickMedia();
                        if (img != null) {
                          controller.img = img;
                          controller.update();
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextInput(
                      label: 'Enter password',
                      controller: controller.registerData['password'],
                    ),
                    const SizedBox(height: 10),
                    TextInput(
                      label: 'Confirm password',
                      controller: controller.registerData['confirmPassword'],
                    ),
                    const SizedBox(height: 20),
                    if (controller.isLoading) ...[
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ] else ...[
                      PrimaryButton(
                        text: "Register",
                        width: double.infinity,
                        onPressed: () {
                          controller.register();
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
