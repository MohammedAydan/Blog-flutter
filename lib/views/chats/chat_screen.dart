import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/controllers/auth_controller.dart';
import 'package:blog_mag/controllers/chats/chat_controller.dart';
import 'package:blog_mag/controllers/chats/logic.dart';
import 'package:blog_mag/models/msg_model.dart';
import 'package:blog_mag/models/user_request_model.dart';
import 'package:blog_mag/views/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/chat_bottom_nav_bar.dart';
import '../../Widgets/message_container.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';
  ChatScreen({super.key});
  final ChatController chatController = Get.put(ChatController());
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final UserReq? user = Get.arguments;
    return GetBuilder(
      init: chatController,
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            backgroundColor: MyMethods.bgColor2,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              UserProfileScreen.routeName,
                              arguments: user!.id,
                            );
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              "${MyMethods.mediaAccountsPath}${user?.imgUrl}",
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${user?.name}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              controller.status.status!
                                  ? "Online"
                                  : "Offline ${controller.status.updatedAt != null ? ChatLogic.getFormattedDate(controller.status.updatedAt!) : ""}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: MyMethods.colorText2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(Icons.call),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.videocam),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.more_vert),
                      ],
                    ),
                  ],
                ),
                if (controller.isLoading && controller.messages.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: LinearProgressIndicator(
                      minHeight: 1,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ] else ...[
                  const SizedBox(),
                ],
              ],
            ),
          ),
          body: Builder(
            builder: (context) {
              if (controller.isLoading && controller.messages.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.messages.isEmpty && !controller.isLoading) {
                return const Center(
                  child: Text("No messages"),
                );
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: controller.scrollController,
                reverse: true,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  Msg msg = controller.messages[index];
                  bool isCurrentUserMessage =
                      msg.userId == authController.user!.id;
                  return MessageContainer(
                    isCurrentUserMessage: isCurrentUserMessage,
                    msg: msg,
                  );
                },
              );
            },
          ),
          bottomNavigationBar: ChatBottomNavBar(controller: controller),
        );
      },
    );
  }
}
