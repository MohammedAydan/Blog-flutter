// import 'package:blog_mag/MyMethods/my_methods.dart';
// import 'package:blog_mag/controllers/audio_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AudioPlayer extends StatelessWidget {
//   const AudioPlayer({super.key, this.audioPath, this.audioUrl});

//   final String? audioPath;
//   final String? audioUrl;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final controller = Get.put(AudioController(audioUrl: audioUrl));
//       return Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(7),
//           border: Border.all(width: 1, color: MyMethods.borderColor),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             if (controller.isPlaying.value) ...[
//               IconButton(
//                 onPressed: controller.pause,
//                 icon: const Icon(Icons.pause_rounded),
//               ),
//             ] else ...[
//               IconButton(
//                 onPressed: () => controller.play(audioUrl!),
//                 icon: const Icon(Icons.play_arrow_rounded),
//               ),
//             ],
//             const SizedBox(width: 10),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       "${controller.duration.value.inMinutes}:${controller.duration.value.inSeconds.remainder(60).toString().padLeft(2, '0')}",
//                     ),
//                     const Text(" / "),
//                     Text(
//                       "${controller.maxDuration.value.inMinutes}:${controller.maxDuration.value.inSeconds.remainder(60).toString().padLeft(2, '0')}",
//                     ),
//                   ],
//                 ),
//                 Slider(
//                   thumbColor: Colors.white,
//                   activeColor: MyMethods.blueColor1,
//                   inactiveColor: MyMethods.bgColor2,
//                   min: 0,
//                   max: controller.maxDuration.value.inSeconds.toDouble() != 0
//                       ? controller.maxDuration.value.inSeconds.toDouble()
//                       : controller.duration.value.inSeconds.toDouble(),
//                   value: controller.duration.value.inSeconds.toDouble(),
//                   onChanged: (e) => controller.setSliderValue(e),
//                 ),
//               ],
//             ),
//             IconButton(
//               onPressed: () => {}, // Add functionality here if needed
//               icon: Icon(Icons.adaptive.more),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
