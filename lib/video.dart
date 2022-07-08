import 'dart:io';

import 'package:flutter/services.dart';
import 'package:svgonvideo/utils/colorassets.dart';
import 'package:svgonvideo/utils/screen_utils.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoViewer extends StatefulWidget {
  VideoViewer (this.videoPath);

  final videoPath;

  @override
  _VideoViewerState createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            _controller.value.isInitialized
                ?  FittedBox(
              fit: BoxFit.fitHeight,
              child: SizedBox(
                height: _controller.value.size?.height ?? 0,
                width: _controller.value.size?.width ?? 0,
                child: VideoPlayer(
                  _controller,
                ),
              ),
            )
                : Container(),
            Positioned(
              left: 20,
              top: 20,
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorAssets.themeColorWhite,
                    borderRadius: BorderRadius.all(Radius.circular(Constant.size52))
                  ),
                  child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: Constant.size35,
                    ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying ? _controller.pause() : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
