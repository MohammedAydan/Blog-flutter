// import 'package:appinio_video_player/appinio_video_player.dart';
// import 'package:blog_mag/MyMethods/my_methods.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class VideoPlayer extends StatefulWidget {
//   const VideoPlayer({super.key, required this.url});
//
//   final String url;
//
//   @override
//   State<VideoPlayer> createState() => _VideoPlayerState();
// }
//
// class _VideoPlayerState extends State<VideoPlayer> {
//   bool loaded = false;
//   late CachedVideoPlayerController videoPlayerController;
//   late CustomVideoPlayerController customVideoPlayerController;
//
//   @override
//   void initState() {
//     super.initState();
//     videoPlayerController = CachedVideoPlayerController.network(widget.url);
//
//     videoPlayerController.initialize().then((_) {
//       customVideoPlayerController = CustomVideoPlayerController(
//         context: context,
//         videoPlayerController: videoPlayerController,
//       );
//       setState(() {
//         loaded = true;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!loaded) {
//       return Container(
//         width: Get.width,
//         height: Get.width * 9.0 / 16.0,
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 1,
//             color: MyMethods.borderColor,
//           ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//
//     return Container(
//       width: Get.width,
//       height: Get.width * 9.0 / 16.0,
//       decoration: BoxDecoration(
//         border: Border.all(
//           width: 1,
//           color: MyMethods.borderColor,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: customVideoPlayerController != null
//             ? CustomVideoPlayer(
//                 customVideoPlayerController: customVideoPlayerController,
//               )
//             : Container(
//                 width: Get.width,
//                 height: Get.width * 9.0 / 16.0,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 1,
//                     color: MyMethods.borderColor,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     if (videoPlayerController.value.isInitialized) {
//       videoPlayerController.dispose();
//     }
//     customVideoPlayerController.dispose();
//     super.dispose();
//   }
// }
