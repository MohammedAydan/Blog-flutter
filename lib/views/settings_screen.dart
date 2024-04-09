import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/buttons/danger_button.dart';
import 'package:blog_mag/Widgets/buttons/outlined_button.dart';
import 'package:blog_mag/Widgets/buttons/primary_button.dart';
import 'package:blog_mag/Widgets/text_input.dart';
import 'package:blog_mag/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';

  SettingsScreen({super.key});

  final SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: settingsController,
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal:
                          BorderSide(width: 1, color: MyMethods.borderColor),
                    ),
                  ),
                  child: Column(
                    children: [
                      if (controller.isLoadingAccountConfirmation) ...[
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                      if (!controller.isLoadingAccountConfirmation) ...[
                        if (controller.reqDone == true &&
                            controller.reqIsDone == false) ...[
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Your request has been submitted",
                              ),
                            ),
                          ),
                        ],
                        if (controller.reqIsDone == true &&
                            controller.reqIsDone == true) ...[
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Your request has been accepted 🎉",
                              ),
                            ),
                          ),
                        ],
                        if (!controller.reqDone && !controller.reqIsDone) ...[
                          const Text(
                            "Account confirmation",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          TextInput(
                            label: "Enter full name in arabic",
                            controller:
                                controller.accountConfirmation['fullNameAr'],
                          ),
                          const SizedBox(height: 10),
                          TextInput(
                            label: "Enter full name in english",
                            controller:
                                controller.accountConfirmation['fullNameEg'],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: MyOutlinedButton(
                                  text: "Front id card",
                                  onPressed: () async {
                                    ImagePicker picker = ImagePicker();
                                    XFile? img = await picker.pickMedia();
                                    if (img != null) {
                                      controller.imgIdf = img;
                                      controller.update();
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: MyOutlinedButton(
                                  text: "back id card",
                                  onPressed: () async {
                                    ImagePicker picker = ImagePicker();
                                    XFile? img = await picker.pickMedia();
                                    if (img != null) {
                                      controller.imgIdb = img;
                                      controller.update();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          PrimaryButton(
                            text: "Request",
                            width: double.infinity,
                            onPressed: () {
                              controller.requestConfirmationAccount();
                            },
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal:
                          BorderSide(width: 1, color: MyMethods.borderColor),
                    ),
                  ),
                  child: Column(
                    children: [
                      if (controller.isLoadingEditProfile) ...[
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                      if (!controller.isLoadingEditProfile) ...[
                        const Text(
                          "Edit profile",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        if (controller.messages['updateProfile'] != null) ...[
                          Text(
                            controller.messages['updateProfile'],
                            style: const TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ],
                        if (controller.errors['updateProfile'] != null) ...[
                          Text(
                            controller.errors['updateProfile'],
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                        const SizedBox(height: 10),
                        TextInput(
                          label: "Enter name",
                          controller: controller.editProfile['name'],
                        ),
                        const SizedBox(height: 10),
                        TextInput(
                          label: "Enter username",
                          controller: controller.editProfile['username'],
                        ),
                        const SizedBox(height: 10),
                        TextInput(
                          label: "Enter email",
                          controller: controller.editProfile['email'],
                        ),
                        const SizedBox(height: 20),
                        TextInput(
                          label: "Enter phone",
                          controller: controller.editProfile['phone'],
                        ),
                        const SizedBox(height: 20),
                        TextInput(
                          label: "Enter age",
                          controller: controller.editProfile['age'],
                        ),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          text: "Update",
                          width: double.infinity,
                          onPressed: () {
                            controller.updateProfile();
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal:
                          BorderSide(width: 1, color: MyMethods.borderColor),
                    ),
                  ),
                  child: Column(
                    children: [
                      if (controller.isLoadingEditPassword) ...[
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                      if (!controller.isLoadingEditPassword) ...[
                        const Text(
                          "Edit password",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        if (controller.messages['updatePassword'] != null) ...[
                          Text(
                            controller.messages['updatePassword'],
                            style: const TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ],
                        if (controller.errors['updatePassword'] != null) ...[
                          Text(
                            controller.errors['updatePassword'],
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                        const SizedBox(height: 10),
                        TextInput(
                          label: "Enter password",
                          controller: controller.editPassword['password'],
                        ),
                        const SizedBox(height: 10),
                        TextInput(
                          label: "Enter new password",
                          controller: controller.editPassword['newPassword'],
                        ),
                        const SizedBox(height: 10),
                        TextInput(
                          label: "Confirm password",
                          controller:
                              controller.editPassword['confirmPassword'],
                        ),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          text: "Update",
                          width: double.infinity,
                          onPressed: () {
                            controller.updatePassword();
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal:
                          BorderSide(width: 1, color: MyMethods.borderColor),
                    ),
                  ),
                  child: Column(
                    children: [
                      if (controller.isLoadingDeleteAccount) ...[
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                      if (!controller.isLoadingDeleteAccount) ...[
                        const Text(
                          "Delete account",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "When you delete the account, you will not again able to recover it again.",
                        ),
                        const SizedBox(height: 20),
                        DangerButton(
                          text: "Delete account",
                          width: double.infinity,
                          onPressed: () {
                            controller.deleteAccount();
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
