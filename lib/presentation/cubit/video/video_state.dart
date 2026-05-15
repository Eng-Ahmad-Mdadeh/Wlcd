part of 'video_cubit.dart';

class VideoState extends Equatable {
  final bool isPlaying;

  const VideoState({required this.isPlaying});

  VideoState copyWith({
    bool? isPlaying,
  }) {
    return VideoState(
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object> get props => [isPlaying];
}
