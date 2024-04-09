import 'dart:async';
import 'dart:convert';

import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/controllers/auth_controller.dart';
import 'package:blog_mag/controllers/chats/logic.dart';
import 'package:blog_mag/models/msg_model.dart';
import 'package:blog_mag/models/status_user_model.dart';
import 'package:blog_mag/models/user_request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  final AuthController _authController = Get.find();
  final UserReq rUser = Get.arguments;
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final GetStorage _storage = GetStorage();
  StreamSubscription? _messageSubscription;

  String _message = "";
  bool isLoading = false;
  bool isTyping = false;
  List<Msg> messages = [];
  StatusUser status = StatusUser(status: false);
  XFile? image;

  String get message => _message;
  set message(String value) {
    _message = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    initGetMessagesCaching();
    initChat();
  }

  void sendMessage() async {
    if (message.isNotEmpty || image != null) {
      isLoading = true;
      update();

      try {
        Msg? msg = await _buildMessage();
        if (msg != null) {
          await _sendMessageAndClearTextField(msg);
          await _sendFCMNotification(msg);
        }
      } catch (e) {
        showErrorSnackbar(e.toString());
      } finally {
        isLoading = false;
        update();
      }
    }
  }

  Future<Msg?> _buildMessage() async {
    String? imgUrl;
    if (image != null) {
      imgUrl = await ChatLogic.uploadImage(image!);
      image = null;
      update();
    }

    return Msg(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: _authController.user!.id!,
      rUserId: rUser.id,
      message: message,
      mediaType: "image",
      media: imgUrl,
    );
  }

  Future<void> _sendMessageAndClearTextField(Msg msg) async {
    await ChatLogic.sendMessage(msg);
    textEditingController.clear();
    update();
  }

  Future<void> _sendFCMNotification(Msg msg) async {
    await MyMethods.sendFCMMessage(
      title: _authController.user!.name!,
      body: msg.message!,
      id: rUser.id.toString(),
      rUserId: msg.userId.toString(),
    );
  }

  void initGetMessagesCaching() {
    final data = _storage.read("${_authController.user?.id}-${rUser.id}");
    if (data != null) {
      List<Msg> msgs = (jsonDecode(data) as List)
          .map<Msg>((e) => Msg.fromJson(e, cc: true))
          .toList();
      messages.assignAll(msgs);
      update();
    }
  }

  void initChat() {
    try {
      ChatLogic.getStatusStream(rUser.id!).listen((event) {
        status = event ?? StatusUser(status: false);
        update();
      }).onError((e) {
        showErrorSnackbar(e.toString());
      });
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
    try {
      isLoading = true;
      update();
      _messageSubscription = ChatLogic.getMessages(
        _authController.user!.id!,
        rUser.id!,
      ).listen((msgs) {
        isLoading = false;
        _updateMessages(ChatLogic.extractMessages(msgs));
        if (msgs.docs.isNotEmpty) {
          cachingMessages(msgs);
        }
      });
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  }

  void _updateMessages(List<Msg> msgs) {
    messages.assignAll(msgs);
    messages.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    update();
  }

  void cachingMessages(QuerySnapshot<Object?> msgs) {
    List dataList = msgs.docs
        .map(
          (e) => Msg.fromJson(e.data() as Map<String, dynamic>).toFullJson(),
        )
        .toList();
    _storage.write(
      "${_authController.user?.id}-${rUser.id}",
      jsonEncode(dataList),
    );
  }

  void goTo() {
    final bottomOffset = scrollController.position.maxScrollExtent;
    scrollController.animateTo(
      bottomOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: MyMethods.bgColor,
      borderRadius: 10,
      colorText: Colors.white,
      borderColor: MyMethods.borderColor,
      borderWidth: 1,
    );
  }

  @override
  void onClose() {
    textEditingController.dispose();
    _messageSubscription?.cancel();
    super.onClose();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
