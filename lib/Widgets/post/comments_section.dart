import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/post/comment.dart';
import 'package:blog_mag/controllers/show_controller.dart';
import 'package:blog_mag/models/comment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommentsSection extends StatelessWidget {
  const CommentsSection({super.key, required this.showController});

  final ShowController showController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: showController,
      builder: (controller) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: MyMethods.bgColor2,
              child: const Text("Comments"),
            ),
            if (!controller.isLoadingComments &&
                controller.comments.isEmpty) ...[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text("No comment"),
                ),
              ),
            ],
            ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.comments.length,
              itemBuilder: (context, index) {
                CommentModel comment = controller.comments[index];
                return Comment(
                  comment: comment,
                  showController: showController,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
