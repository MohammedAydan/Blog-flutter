// import 'package:appinio_video_player/appinio_video_player.dart';
// import 'package:blog_mag/MyMethods/my_methods.dart';
// import 'package:blog_mag/controllers/video_viewer_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class VideoViewer extends StatelessWidget {
//   const VideoViewer({super.key, required this.url});
//
//   final String url;
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<VideoViewerController>(
//       init: VideoViewerController(),
//       builder: (controller) {
//         controller.setUrl(url);
//         if (controller.videoPlayerController == null ||
//             controller.customVideoPlayerController == null) {
//           return Container(
//             width: Get.width,
//             height: Get.width * 9.0 / 16.0,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 width: 1,
//                 color: MyMethods.borderColor,
//               ),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//         try {
//           return Container(
//             width: Get.width,
//             height: Get.width * 9.0 / 16.0,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 width: 1,
//                 color: MyMethods.borderColor,
//               ),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: CustomVideoPlayer(
//                 customVideoPlayerController:
//                     controller.customVideoPlayerController!,
//               ),
//             ),
//           );
//         } catch (e) {
//           return Container(
//             width: Get.width,
//             height: Get.width * 9.0 / 16.0,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 width: 1,
//                 color: MyMethods.borderColor,
//               ),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Center(
//               child: Text("Error: ${e.toString()}"),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
