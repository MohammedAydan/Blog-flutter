import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/material.dart';

class CustomAudioControls extends StatelessWidget {
  const CustomAudioControls({super.key});

  @override
  Widget build(BuildContext context) {
    final ChewieAudioController chewieController =
        ChewieAudioController.of(context);

    return ChewieAudioControllerProvider(
      controller: chewieController,
      child: Container(
        color: Colors.red,
        child: Row(
          children: [
            if (chewieController.videoPlayerController.value.isPlaying) ...[
              IconButton(
                onPressed: () {
                  chewieController.togglePause();
                },
                icon: const Icon(Icons.pause_rounded),
              ),
            ] else ...[
              IconButton(
                onPressed: () {
                  chewieController.togglePause();
                },
                icon: const Icon(Icons.play_arrow_rounded),
              ),
            ],
            Expanded(
              child: Slider(
                // max: chewieController.duration.inSeconds.toDouble(),
                // value: chewieController.position.inSeconds.toDouble(),
                value: 1,
                onChanged: (value) {
                  final Duration newPosition = Duration(seconds: value.toInt());
                  chewieController.seekTo(newPosition);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
