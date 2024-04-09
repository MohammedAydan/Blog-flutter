import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/controllers/chats/logic.dart';
import 'package:blog_mag/models/msg_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageContainer extends StatelessWidget {
  final bool isCurrentUserMessage;
  final Msg msg;

  const MessageContainer({
    super.key,
    required this.isCurrentUserMessage,
    required this.msg,
  });

  @override
  Widget build(BuildContext context) {
    if (!isCurrentUserMessage) {
      if (msg.readAt == null) {
        ChatLogic.updateReadMessage(msg);
      }
    }

    return GestureDetector(
      onLongPress: () {
        print("onLongPress");
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: isCurrentUserMessage
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: Get.width * 0.8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isCurrentUserMessage
                    ? MyMethods.blueColor1
                    : MyMethods.bgColor2,
                borderRadius: BorderRadius.only(
                  bottomLeft: !isCurrentUserMessage
                      ? const Radius.circular(20)
                      : Radius.zero,
                  bottomRight: !isCurrentUserMessage
                      ? Radius.zero
                      : const Radius.circular(20),
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  if (msg.message!.isNotEmpty) ...[
                    Text(
                      "${msg.message}",
                      style: const TextStyle(
                        color: MyMethods.colorText1,
                        fontSize: 16,
                      ),
                    ),
                  ],
                  if (msg.media != null) ...[
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        _showImageDialog(msg.media!);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          msg.media!,
                          width: Get.width * 0.7,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isCurrentUserMessage) ...[
                    _buildReadStatusIcon(),
                    const SizedBox(width: 5),
                  ],
                  Text(
                    ChatLogic.getFormattedDate(msg.createdAt!),
                    style: const TextStyle(
                      color: MyMethods.colorText2,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadStatusIcon() {
    return Icon(
      Icons.done_all_rounded,
      size: 15,
      color: msg.readAt == null ? MyMethods.bgColor2 : MyMethods.blueColor2,
    );
  }

  void _showImageDialog(String imageUrl) {
    Get.dialog(
      Dialog(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Image.network(
            imageUrl,
            width: Get.width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
