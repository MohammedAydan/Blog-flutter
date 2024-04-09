import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/custom_audio_controls.dart';
import 'package:flutter/material.dart';
import 'package:chewie_audio/chewie_audio.dart';
import 'package:video_player/video_player.dart';

class AudioPlayer extends StatelessWidget {
  const AudioPlayer({super.key, required this.mediaUrl});
  final String mediaUrl;

  @override
  Widget build(BuildContext context) {
    String mediaUrl = "http://blog-mag.ddns.net/Assets/Posts/${this.mediaUrl}";
    return ChewieAudio(
      controller: ChewieAudioController(
        materialProgressColors: ChewieProgressColors(
          playedColor: MyMethods.blueColor1,
          handleColor: MyMethods.blueColor1,
          backgroundColor: MyMethods.bgColor,
        ),
        cupertinoProgressColors: ChewieProgressColors(
          playedColor: MyMethods.blueColor1,
          handleColor: MyMethods.blueColor1,
          backgroundColor: MyMethods.bgColor,
        ),
        customControls: const CupertinoControls(
          backgroundColor: MyMethods.bgColor2,
          iconColor: Colors.white,
        ),
        videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(mediaUrl),
        ),
        autoPlay: false,
        looping: false,
        showControls: true,
        autoInitialize: true,
      ),
    );
  }
}
