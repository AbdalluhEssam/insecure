import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreenCh extends StatefulWidget {
  const VideoPlayerScreenCh(
      {super.key, required this.videoUrl, required this.title});

  final String videoUrl;
  final String title;

  @override
  State<StatefulWidget> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreenCh> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl), // Replace with your video URL
    );
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.hasError) {
        log('Error: ${_videoPlayerController.value.errorDescription}');
      }
    });

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      // autoPlay: true,
      // looping: true,
      fullScreenByDefault: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }
}