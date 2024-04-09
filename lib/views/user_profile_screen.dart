import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/buttons/danger_button.dart';
import 'package:blog_mag/Widgets/buttons/primary_button.dart';
import 'package:blog_mag/Widgets/buttons/success_button.dart';
import 'package:blog_mag/Widgets/buttons/sucendary_button.dart';
import 'package:blog_mag/controllers/auth_controller.dart';
import 'package:blog_mag/controllers/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatelessWidget {
  static const String routeName = '/userProfile';

  UserProfileScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(
      init: UserProfileController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("User Profile"),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            color: MyMethods.colorText1,
            backgroundColor: MyMethods.bgColor2,
            onRefresh: () async => controller.getUser(),
            child: ListView(
              children: [
                if (controller.isLoading) ...[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: 30),
                  if (controller.user != null) ...[
                    CircleAvatar(
                        backgroundColor: MyMethods.bgColor2,
                        radius: 100,
                        backgroundImage: NetworkImage(
                          "${MyMethods.mediaAccountsPath}/${controller.user!.imgUrl}",
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        const Text("Friends"),
                        Text(controller.user?.name ?? "N/A"),
                        // Null-aware operator and default value
                        Text("@${controller.user?.username ?? "N/A"}"),

                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (controller.isLoadingReq) ...[
                              const Center(
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 5,
                                  ),
                                ),
                              ),
                            ],
                            if (!controller.isLoadingReq &&
                                controller.userRequest == null) ...[
                              PrimaryButton(
                                text: "Request",
                                onPressed: () {
                                  controller.sendRequest();
                                },
                              ),
                            ],
                            if (!controller.isLoadingReq &&
                                controller.userRequest != null &&
                                controller.userRequest!.status != null &&
                                controller.userRequest!.ownerId != null &&
                                controller.userRequest!.status! &&
                                controller.userRequest!.ownerId !=
                                    authController.user!.id) ...[
                              SucendaryButton(
                                text: "Cancel friend",
                                onPressed: () {
                                  controller.cancelRequest();
                                },
                              ),
                            ],
                            if (!controller.isLoadingReq &&
                                controller.userRequest != null &&
                                controller.userRequest!.status != null &&
                                controller.userRequest!.ownerId != null &&
                                controller.userRequest!.status! &&
                                controller.userRequest!.ownerId ==
                                    authController.user!.id) ...[
                              SucendaryButton(
                                text: "Cancel friend",
                                onPressed: () {
                                  controller.cancelRequest();
                                },
                              ),
                            ],
                            if (!controller.isLoadingReq &&
                                controller.userRequest != null &&
                                controller.userRequest!.status != null &&
                                !controller.userRequest!.status! &&
                                controller.userRequest!.ownerId != null &&
                                controller.userRequest!.ownerId !=
                                    authController.user!.id) ...[
                              SuccessButton(
                                text: "Accept request",
                                onPressed: () {
                                  controller.acceptRequest();
                                },
                              ),
                              const SizedBox(width: 10),
                              DangerButton(
                                text: "Unaccepted request",
                                onPressed: () {
                                  controller.cancelRequest();
                                },
                              ),
                            ],
                            if (!controller.isLoadingReq &&
                                controller.userRequest != null &&
                                controller.userRequest!.status != null &&
                                !controller.userRequest!.status! &&
                                controller.userRequest!.ownerId != null &&
                                controller.userRequest!.ownerId ==
                                    authController.user!.id) ...[
                              SucendaryButton(
                                text: "Cancel request",
                                onPressed: () {
                                  controller.cancelRequest();
                                },
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ] else ...[
                    // Handle the case where controller.user is null
                    const Text("User data not available"),
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
