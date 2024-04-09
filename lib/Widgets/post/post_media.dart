import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/audio_player.dart';
import 'package:blog_mag/Widgets/buttons/outlined_button.dart';
import 'package:blog_mag/Widgets/post/post.dart';
import 'package:blog_mag/Widgets/vid_player.dart';
import 'package:blog_mag/models/post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:voice_message_package/voice_message_package.dart';

class PostMedia extends StatelessWidget {
  const PostMedia({super.key, required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    PostModel? sharing =
        post.sharing != null ? PostModel.fromJson(post.sharing!) : null;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.title != null) ...[
              Text(
                post.title!,
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
            if (post.body != null) ...[
              const SizedBox(height: 10),
              Text(
                post.body!,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
            // show images
            if (post.mediaType != null) ...[
              if (post.mediaType!.startsWith("image")) ...[
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed(ShowImage.routeName, arguments: post.mediaUrl);
                    Get.dialog(
                      Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Image.network(
                                  "${MyMethods.mediaPostsPath}/${post.mediaUrl}"),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyMethods.bgColor2,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: double.infinity,
                      // height: 200,
                      child: Image.network(
                        "${MyMethods.mediaPostsPath}/${post.mediaUrl}",
                      ),
                    ),
                  ),
                ),
              ] else if (post.mediaType!.startsWith("audio")) ...[
                const SizedBox(height: 10),
                AudioPlayer(mediaUrl: post.mediaUrl!),

                // AudioPlayer(
                //   audioUrl:
                //       "http://blog-mag.ddns.net/Assets/Posts/${post.mediaUrl!}",
                // ),
                // MyOutlinedButton(
                //   width: double.infinity,
                //   text: post.mediaUrl!.split("/").last,
                // ),
              ] else if (post.mediaType!.startsWith("video")) ...[
                const SizedBox(height: 10),
                VidPlayer(
                  url:
                      "http://blog-mag.ddns.net/Assets/Posts/${post.mediaUrl!}",
                ),
                // VideoPlayer(
                //   url: "${MyMethods.mediaPostsPath}${post.mediaUrl!}",
                // ),
                // VideoViewer(
                //   url: "${MyMethods.mediaPostsPath}${post.mediaUrl!}",
                // ),
              ] else if (post.mediaUrl!.isNotEmpty) ...[
                const SizedBox(height: 10),
                MyOutlinedButton(
                  onPressed: () async {
                    // Get.to(() => VideoListScreen());

                    // Dio dio = Dio();
                    // String nameFile = post.mediaUrl!.split("/").last;
                    // final dir = await getApplicationDocumentsDirectory();
                    // String filePath = "${dir.path}/$nameFile";
                    // String dUrl = "${MyMethods.mediaPostsPath}${post.mediaUrl}";

                    // try {
                    //   await dio.download(
                    //     dUrl,
                    //     filePath,
                    //     onReceiveProgress: (rec, total) {
                    //       print("Download: $rec, Total: $total");
                    //     },
                    //   );
                    //   print("Download complete");
                    // } catch (e) {
                    //   print("Error during download: $e");
                    // }
                  },
                  width: double.infinity,
                  text: post.mediaUrl!.split("/").last,
                ),
              ],
            ] else ...[
              if (post.mediaUrl != null) ...[
                const SizedBox(height: 10),
                MyOutlinedButton(
                  onPressed: () async {
                    Dio dio = Dio();
                    String nameFile = post.mediaUrl!.split("/").last;
                    final dir = await getApplicationDocumentsDirectory();
                    String filePath = "${dir.path}/$nameFile";
                    String dUrl = "${MyMethods.mediaPostsPath}${post.mediaUrl}";
                    await dio.download(
                      dUrl,
                      filePath,
                    );
                  },
                  width: double.infinity,
                  text: post.mediaUrl!.split("/").last,
                ),
              ],
            ],

            // sharing post
            if (sharing != null) ...[
              const SizedBox(height: 10),
              Post(post: sharing, fullBorder: true),
            ],
          ],
        ),
      ),
    );
  }
}
