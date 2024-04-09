import 'dart:io';

import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class VidPlayer extends StatefulWidget {
  const VidPlayer({
    super.key,
    this.url,
    this.path,
    this.outoPlay = false,
  });

  final String? url;
  final String? path;
  final bool? outoPlay;

  @override
  _VidPlayerState createState() => _VidPlayerState();
}

class _VidPlayerState extends State<VidPlayer> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      autoInitialize: true,
      autoPlay: widget.outoPlay!,
      videoPlayerController: widget.url != null
          ? VideoPlayerController.network(widget.url!)
          : VideoPlayerController.file(File(widget.path!)),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: MyMethods.borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FlickVideoPlayer(
          wakelockEnabled: true,
          wakelockEnabledFullscreen: true,
          flickManager: flickManager,
        ),
      ),
    );
  }
}
