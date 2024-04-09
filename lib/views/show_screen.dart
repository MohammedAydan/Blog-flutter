import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/buttons/primary_button.dart';
import 'package:blog_mag/Widgets/post/comments_section.dart';
import 'package:blog_mag/Widgets/post/post.dart';
import 'package:blog_mag/Widgets/text_input.dart';
import 'package:blog_mag/controllers/show_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowScreen extends StatelessWidget {
  static const String routeName = '/show';

  ShowScreen({super.key});
  final ShowController showController = Get.put(ShowController());
  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();

    return GetBuilder<ShowController>(
      init: showController,
      builder: (showController) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(),
          body: RefreshIndicator(
            color: MyMethods.colorText1,
            backgroundColor: MyMethods.bgColor2,
            onRefresh: () async => await Future.delayed(5.seconds),
            child: ListView(
              children: [
                if (showController.isLoading == true) ...[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ] else ...[
                  if (showController.post != null) ...[
                    Post(
                      showMode: true,
                      post: showController.post!,
                      showController: showController,
                    ),
                  ],
                  if (showController.isLoadingComments == true) ...[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ] else ...[
                    CommentsSection(showController: showController),
                  ],
                ],
              ],
            ),
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(
              bottom: context.mediaQueryViewInsets.bottom,
            ),
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: 90,
            decoration: const BoxDecoration(
              color: MyMethods.bgColor,
              border: Border(
                top: BorderSide(
                  color: MyMethods.borderColor,
                  width: 4,
                ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextInput(
                    label: "Enter comment",
                    controller: showController.commentTextEditController,
                    onChanged: (e) => showController.setCommentText(e),
                  ),
                ),
                if (showController.comment.isNotEmpty) ...[
                  const SizedBox(width: 10),
                  PrimaryButton(
                    text: "Add",
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      showController.addComment();
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
