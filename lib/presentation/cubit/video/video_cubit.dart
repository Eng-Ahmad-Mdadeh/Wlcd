import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final VideoPlayerController _controller;
  final bool _autoPlay;

  VideoPlayerController get controller => _controller;

  VideoCubit(String url, bool network, {bool autoPlay = false})
    : _controller = network ? VideoPlayerController.networkUrl(Uri.parse(url)) : VideoPlayerController.file(File(url)),
      _autoPlay = autoPlay,
      super(VideoState(isPlaying: autoPlay)) {
    _initialize();
  }

  Future<void> _initialize() async {
    await _controller.initialize();
    await _controller.setLooping(true);
    if (_autoPlay) {
      await _controller.play();
    } else {
      await _controller.pause();
    }
  }

  void changeStatus(bool isPlaying) {
    emit(state.copyWith(isPlaying: isPlaying));
  }

  void play() {
    if (!_controller.value.isInitialized) {
      return;
    }
    _controller.play();
  }

  void pause() {
    if (!_controller.value.isInitialized) {
      return;
    }
    _controller.pause();
  }

  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }
}
