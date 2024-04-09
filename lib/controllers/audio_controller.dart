// import 'package:audioplayers/audioplayers.dart';
// import 'package:get/get.dart';
// import 'package:get/state_manager.dart';

// class AudioController extends GetxController {
//   Rx<Duration> maxDuration = const Duration().obs;
//   Rx<Duration> duration = const Duration().obs;
//   RxString audioPath = ''.obs;
//   RxString audioUrl = ''.obs;
//   RxBool isPlaying = false.obs;
//   RxDouble sliderValue = 0.0.obs;
//   late AudioPlayer audioPlayer = AudioPlayer();

//   AudioController({String? audioPath, String? audioUrl}) {
//     if (audioUrl != null) {
//       audioPlayer = AudioPlayer(playerId: audioUrl);
//       audioPlayer
//           .setSourceUrl(audioUrl)
//           .then((value) async => await getd(audioUrl));
//     }
//   }

//   void play(String url) async {
//     isPlaying(true);
//     await audioPlayer.setSourceUrl(url);
//     await audioPlayer.resume();
//     try {
//       audioPlayer.onPositionChanged.listen((Duration duration_) {
//         duration(duration_);
//       });
//       audioPlayer.onPlayerComplete.listen((e) {
//         pause();
//         reset();
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   void pause() async {
//     isPlaying(false);
//     try {
//       await audioPlayer.pause();
//     } catch (e) {
//       // Handle pause error here (optional)
//       print(e);
//     }
//   }

//   void setSliderValue(double value) async {
//     sliderValue(value);
//     try {
//       await audioPlayer.seek(Duration(seconds: value.toInt()));
//     } catch (e) {
//       print(e);
//     }
//   }

//   void reset() {
//     isPlaying(false);
//     duration(const Duration());
//   }

//   Future getd(String audioUrl) async {
//     try {
//       await audioPlayer.setSourceUrl(audioUrl);
//       await audioPlayer.getDuration().then((value) {
//         if (value != null) {
//           maxDuration(Duration(seconds: value.inSeconds));
//         } else {
//           // Handle case where duration cannot be retrieved (optional)
//         }
//       });
//     } catch (e) {
//       print(e);
//       // Handle error getting duration (optional)
//     }
//   }

//   @override
//   void dispose() async {
//     super.dispose();
//     await audioPlayer.dispose();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//     audioPlayer.pause();
//     audioPlayer.dispose();
//   }
// }
