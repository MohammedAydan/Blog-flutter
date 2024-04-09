import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/controllers/auth_controller.dart';
import 'package:blog_mag/controllers/chats/chats_controller.dart';
import 'package:blog_mag/controllers/chats/logic.dart';
import 'package:blog_mag/models/msg_model.dart';
import 'package:blog_mag/models/user_request_model.dart';
import 'package:blog_mag/views/chats/chat_screen.dart';
import 'package:blog_mag/views/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsScreen extends StatelessWidget {
  static const String routeName = '/chats';
  ChatsScreen({super.key});
  final ChatsController chatsController = Get.put(
    ChatsController(),
    permanent: true,
  );
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyMethods.bgColor2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Chats"),
            GetBuilder(
              init: chatsController,
              builder: (controller) {
                if (controller.isLoading && controller.friends.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: LinearProgressIndicator(
                      minHeight: 1,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
      body: GetBuilder(
        init: chatsController,
        builder: (controller) {
          if (controller.isLoading && controller.friends.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: chatsController.friends.length,
            itemBuilder: (context, index) {
              FullUserRequest user = chatsController.friends[index];
              if (user.ownerId == authController.user!.id) {
                UserReq? userData = user.user;
                return UserCard(
                  userData: userData,
                  authController: authController,
                );
              } else {
                UserReq? userData = user.owner;

                return UserCard(
                  userData: userData,
                  authController: authController,
                );
              }
            },
          );
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  UserCard({
    super.key,
    required this.userData,
    required this.authController,
  });

  final UserReq? userData;
  final AuthController authController;
  final ChatsController chatsController = Get.find();

  @override
  Widget build(BuildContext context) {
    // chatsController.friends.map((e) => e.userId == userData!.id || e.userId == userData!.id);
    return ListTile(
      textColor: Colors.white,
      onTap: () {
        Get.toNamed(ChatScreen.routeName, arguments: userData);
      },
      title: Text("${userData?.name}"),
      subtitle: StreamBuilder(
        stream: ChatLogic.getLastMessage(
          authController.user!.id!,
          userData!.id!,
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.docs.isEmpty) {
            return const SizedBox();
          }
          Msg msg = Msg.fromJson(snapshot.data!.docs.first.data());
          bool isCurrentUserMessage = msg.userId == authController.user!.id;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  if (isCurrentUserMessage) ...[
                    Icon(
                      msg.readAt != null
                          ? Icons.done_all_rounded
                          : Icons.done_all_rounded,
                      color: msg.readAt != null
                          ? MyMethods.blueColor2
                          : MyMethods.bgColor2,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                  ],
                  SizedBox(
                    width: Get.width * 0.5,
                    child: Text(
                      "Message: ${msg.message}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Text(
                  ChatLogic.getFormattedDate(msg.createdAt!),
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          );
        },
      ),
      leading: InkWell(
        onTap: () {
          Get.toNamed(
            UserProfileScreen.routeName,
            arguments: userData!.id,
          );
        },
        child: CircleAvatar(
          backgroundImage: userData != null
              ? NetworkImage(
                  MyMethods.mediaAccountsPath + userData!.imgUrl!,
                )
              : null,
        ),
      ),
    );
  }
}
