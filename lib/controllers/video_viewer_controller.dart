// import 'package:appinio_video_player/appinio_video_player.dart';
// import 'package:get/get.dart';
//
// class VideoViewerController extends GetxController {
//   CachedVideoPlayerController? videoPlayerController;
//   CustomVideoPlayerController? customVideoPlayerController;
//
//   String? videoUrl;
//
//   void initializeVideoPlayer() {
//     if (videoUrl != null) {
//       try {
//         // Update the video URL to use HTTPS
//         videoPlayerController = CachedVideoPlayerController.network(videoUrl!);
//
//         videoPlayerController!.initialize().then((_) {
//           customVideoPlayerController = CustomVideoPlayerController(
//             context: Get.context!,
//             videoPlayerController: videoPlayerController!,
//           );
//           update(); // Ensure that the UI is updated after initialization.
//         });
//       } catch (e) {
//         print(e);
//       }
//     }
//   }
//
//   setUrl(String url) {
//     videoUrl = url;
//     initializeVideoPlayer();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     if (customVideoPlayerController != null) {
//       customVideoPlayerController!.dispose();
//     }
//   }
// }
