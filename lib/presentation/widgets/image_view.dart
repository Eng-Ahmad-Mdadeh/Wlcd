// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:wlcd/core/constants/api_endpoints.dart';
// import 'package:wlcd/core/extension/image_type_extension.dart';
// import 'package:skeletonizer/skeletonizer.dart';
// import 'package:video_player/video_player.dart';
// import '../../core/resources/app_colors.dart';
// import '../../core/resources/app_values.dart';
// import '../cubit/video/video_cubit.dart';
// import 'custom_avatar.dart';
//
// class ImageView extends StatelessWidget {
//   ImageView({
//     super.key,
//     required this.imagePath,
//     this.name,
//     this.id,
//     this.height,
//     this.width,
//     this.color,
//     this.fit,
//     this.alignment,
//     this.onTap,
//     this.radius,
//     this.margin,
//     this.border,
//     this.placeHolder = const Icon(FontAwesome.camera_retro_solid),
//     this.errorListener,
//     this.isExpanded = false,
//     this.showControls = true,
//     this.autoPlay = false,
//     this.showErrorWidget = false,
//   }) : errorWidget = name != null ? CustomAvatar(name: name) : null;
//
//   final String imagePath;
//   final String? id;
//   final String? name;
//   final double? height;
//   final double? width;
//   final Color? color;
//   final BoxFit? fit;
//   final Icon placeHolder;
//   final Widget? errorWidget;
//   final Alignment? alignment;
//   final EdgeInsetsGeometry? margin;
//   final BorderRadius? radius;
//   final BoxBorder? border;
//   final VoidCallback? onTap;
//   final bool isExpanded;
//   final bool showControls;
//   final bool autoPlay;
//   final bool showErrorWidget;
//   final void Function(Object)? errorListener;
//
//   @override
//   Widget build(BuildContext context) {
//     return alignment != null
//         ? Align(
//             alignment: alignment!,
//             child: _buildWidget(),
//           )
//         : _buildWidget();
//   }
//
//   Widget _buildWidget() {
//     return Padding(
//       padding: margin ?? EdgeInsets.zero,
//       child: InkWell(
//         onTap: onTap,
//         child: _buildCircleImage(),
//       ),
//     );
//   }
//
//   Widget _buildCircleImage() {
//     if (radius != null) {
//       return ClipRRect(
//         borderRadius: radius ?? BorderRadius.zero,
//         child: _buildImageWithBorder(),
//       );
//     } else {
//       return _buildImageWithBorder();
//     }
//   }
//
//   Widget _buildImageWithBorder() {
//     if (border != null) {
//       return Container(
//         decoration: BoxDecoration(
//           border: border,
//           borderRadius: radius,
//         ),
//         child: _buildImageView(),
//       );
//     } else {
//       return _buildImageView();
//     }
//   }
//
//   Widget _buildImageView() {
//     final type = imagePath.imageType;
//
//     switch (type) {
//       case ImageType.svg:
//         return SizedBox(
//           height: height,
//           width: width,
//           child: SvgPicture.asset(
//             imagePath,
//             height: height,
//             width: width,
//             fit: fit ?? BoxFit.contain,
//             placeholderBuilder: (context) => Container(
//               height: height,
//               width: width,
//               decoration: const BoxDecoration(color: AppColors.backGround),
//             ),
//             colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
//           ),
//         );
//       case ImageType.networkSvg:
//         if (isExpanded) {
//           final resolvedPath = _resolveNetworkPath(imagePath);
//           return Container(
//             height: height,
//             width: width,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//             ),
//             child: SvgPicture.network(
//               resolvedPath,
//               height: height,
//               width: width,
//               fit: fit ?? BoxFit.contain,
//               placeholderBuilder: (context) => Container(
//                 height: height,
//                 width: width,
//                 decoration: const BoxDecoration(color: AppColors.backGround),
//               ),
//               colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
//             ),
//           );
//         } else {
//           final resolvedPath = _resolveNetworkPath(imagePath);
//           return SizedBox(
//             height: height,
//             width: width,
//             child: SvgPicture.network(
//               resolvedPath,
//               height: height,
//               width: width,
//               fit: fit ?? BoxFit.contain,
//               colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
//               placeholderBuilder: (context) => Container(
//                 height: height,
//                 width: width,
//                 decoration: const BoxDecoration(color: AppColors.backGround),
//               ),
//             ),
//           );
//         }
//       case ImageType.networkPng:
//         final resolvedPath = _resolveNetworkPath(imagePath);
//         if (isExpanded) {
//           return Container(
//             height: height,
//             width: width,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               image: DecorationImage(
//                 image: NetworkImage(resolvedPath),
//                 colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.color),
//                 fit: fit,
//               ),
//             ),
//             child: showErrorWidget ? errorWidget : null,
//           );
//         } else {
//           return Image.network(
//             resolvedPath,
//             fit: fit,
//             height: height,
//             width: width,
//             color: color,
//             errorBuilder: (_, __, ___) {
//               return errorWidget ?? Icon(Icons.image_outlined, color: color ?? AppColors.red);
//             },
//             loadingBuilder: (context, child, loadingProgress) {
//               if (loadingProgress == null) return child;
//
//               return Skeletonizer(
//                 effect: ShimmerEffect(
//                   baseColor: Colors.grey[300]!,
//                   begin: Alignment.centerRight,
//                   end: Alignment.centerLeft,
//                   highlightColor: Colors.grey[100]!,
//                   duration: const Duration(milliseconds: 400),
//                 ),
//                 enabled: true,
//                 child: SizedBox(
//                   height: AppHeight.h40,
//                   width: AppWidth.w40,
//                   child: LinearProgressIndicator(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(AppRadius.r10),
//                     ),
//                     value: 1,
//                     color: AppColors.backGround,
//                     backgroundColor: AppColors.lightGrey,
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       case ImageType.file:
//         return Image.file(
//           File(imagePath),
//           height: height,
//           width: width,
//           fit: fit ?? BoxFit.cover,
//           color: color,
//         );
//       case ImageType.networkMp4:
//       case ImageType.mp4:
//         final resolvedPath = type == ImageType.networkMp4 ? _resolveNetworkPath(imagePath) : imagePath;
//         return Container(
//           color: AppColors.white,
//           width: width,
//           height: height,
//           child: VideoPlayerItemWidget(
//             videoUrl: resolvedPath,
//             showControls: showControls,
//             network: type == ImageType.networkMp4,
//             width: width,
//             height: height,
//           ),
//         );
//       case ImageType.empty:
//         return Icon(Icons.image_outlined, color: color ?? AppColors.red);
//       case ImageType.png:
//       default:
//         return Image.asset(
//           imagePath,
//           height: height,
//           width: width,
//           fit: fit ?? BoxFit.cover,
//           color: color,
//         );
//     }
//   }
//
//   String _resolveNetworkPath(String path) {
//     if (path.startsWith('http://') || path.startsWith('https://')) {
//       return path;
//     }
//
//     final trimmedPath = path.trim();
//     if (trimmedPath.isEmpty) {
//       return path;
//     }
//
//     final normalized = trimmedPath.startsWith('/') ? trimmedPath.substring(1) : trimmedPath;
//     final segments = normalized.split('/').where((segment) => segment.isNotEmpty).toList();
//
//     if (segments.isEmpty) {
//       return _baseAuthority;
//     }
//
//     final hasStoragePrefix = segments.first == 'storage';
//     final resolvedSegments = <String>[
//       if (!hasStoragePrefix) 'storage',
//       ...segments,
//     ];
//
//     final resolvedUri = Uri(
//       scheme: _baseUri.scheme,
//       host: _baseUri.host,
//       port: _baseUri.hasPort ? _baseUri.port : null,
//       pathSegments: resolvedSegments,
//     );
//
//     return resolvedUri.toString();
//   }
//
//   static final Uri _baseUri = Uri.parse(ApiEndpoints.baseUrl);
//   static final String _baseAuthority = Uri(
//     scheme: _baseUri.scheme,
//     host: _baseUri.host,
//     port: _baseUri.hasPort ? _baseUri.port : null,
//   ).toString();
// }
//
// class VideoPlayerItemWidget extends StatelessWidget {
//   final String videoUrl;
//   final bool showControls;
//   final bool autoPlay;
//   final bool network;
//   final double? height;
//   final double? width;
//
//   const VideoPlayerItemWidget({
//     super.key,
//     required this.videoUrl,
//     required this.network,
//     this.showControls = true,
//     this.autoPlay = false,
//     this.width,
//     this.height,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => VideoCubit(videoUrl, network),
//       child: BlocBuilder<VideoCubit, VideoState>(
//         builder: (context, state) {
//           return VideoPlayerItemBody(
//             controller: context.read<VideoCubit>().controller,
//             isPlaying: state.isPlaying,
//             showControls: showControls,
//             width: width,
//             height: height,
//           );
//         },
//       ),
//     );
//   }
// }
//
// class VideoPlayerItemBody extends StatelessWidget {
//   final VideoPlayerController controller;
//   final bool showControls;
//   final bool autoPlay;
//   final bool isPlaying;
//   final double? height;
//   final double? width;
//
//   const VideoPlayerItemBody({
//     super.key,
//     required this.controller,
//     required this.showControls,
//     required this.isPlaying,
//     this.width,
//     this.height,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Align(
//           alignment: Alignment.center,
//           child: SizedBox(
//             width: width,
//             height: height,
//             child: VideoPlayer(controller),
//           ),
//         ),
//         if (showControls)
//           Align(
//             alignment: Alignment.center,
//             child: VideoControls(
//               isPlaying: isPlaying,
//             ),
//           ),
//       ],
//     );
//   }
// }
//
// class VideoControls extends StatelessWidget {
//   final bool isPlaying;
//
//   const VideoControls({super.key, this.isPlaying = false});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<VideoCubit, VideoState>(
//       builder: (context, state) {
//         return !isPlaying
//             ? IconButton(
//                 icon: Container(
//                   padding: const EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                     color: AppColors.black.withOpacity(.7),
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                   child: const Icon(
//                     Icons.play_arrow,
//                     color: AppColors.white,
//                   ),
//                 ),
//                 onPressed: () {
//                   context.read<VideoCubit>().changeStatus(true);
//                   context.read<VideoCubit>().play();
//                 },
//               )
//             : IconButton(
//                 icon: Container(
//                   padding: const EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                     color: AppColors.black.withOpacity(.7),
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                   child: const Icon(
//                     Icons.pause,
//                     color: AppColors.white,
//                   ),
//                 ),
//                 onPressed: () {
//                   context.read<VideoCubit>().changeStatus(false);
//                   context.read<VideoCubit>().pause();
//                 },
//               );
//       },
//     );
//   }
// }
import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:video_player/video_player.dart';
import '../../core/extension/image_type_extension.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_values.dart';
import '../cubit/video/video_cubit.dart';
import 'custom_avatar.dart';

class ImageView extends StatelessWidget {
  ImageView({
    super.key,
    required this.imagePath,
    this.name,
    this.id,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = const Icon(FontAwesome.camera_retro_solid),
    this.errorListener,
    this.isExpanded = false,
    this.showControls = true,
    this.autoPlay = false,
    this.showErrorWidget = false,
  }) : errorWidget = name != null ? CustomAvatar(name: name) : null;

  final String imagePath;
  final String? id;
  final String? name;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final Icon placeHolder;
  final Widget? errorWidget;
  final Alignment? alignment;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? radius;
  final BoxBorder? border;
  final VoidCallback? onTap;
  final bool isExpanded;
  final bool showControls;
  final bool autoPlay;
  final bool showErrorWidget;
  final void Function(Object)? errorListener;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  Widget _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  Widget _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    switch (imagePath.imageType) {
      case ImageType.svg:
        return SizedBox(
          height: height,
          width: width,
          child: SvgPicture.asset(
            imagePath,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            placeholderBuilder: (context) => Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(color: AppColors.backGround),
            ),
            colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
          ),
        );
      case ImageType.networkSvg:
        if (isExpanded) {
          return Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: SvgPicture.network(
              imagePath,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              placeholderBuilder: (context) => Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(color: AppColors.backGround),
              ),
              colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
            ),
          );
        } else {
          return SizedBox(
            height: height,
            width: width,
            child: SvgPicture.network(
              imagePath,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
              placeholderBuilder: (context) => Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(color: AppColors.backGround),
              ),
            ),
          );
        }
      case ImageType.networkPng:
        if (isExpanded) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  imagePath,
                  errorListener: errorListener,
                ),
                colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.color),
                fit: fit,
              ),
            ),
            child: showErrorWidget ? errorWidget : null,
          );
        } else {
          return CachedNetworkImage(
            fit: fit,
            height: height,
            width: width,
            imageUrl: imagePath,
            color: color,
            errorWidget: (_, __, ___) => errorWidget ?? Icon(Icons.image_outlined, color: color ?? AppColors.red),
            placeholder: (context, url) => Skeletonizer(
              effect: ShimmerEffect(
                baseColor: Colors.grey[300]!,
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                highlightColor: Colors.grey[100]!,
                duration: const Duration(milliseconds: 400),
              ),
              enabled: true,
              child: SizedBox(
                height: AppHeight.h40,
                width: AppWidth.w40,
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppRadius.r10),
                  ),
                  value: 1,
                  color: AppColors.backGround,
                  backgroundColor: AppColors.lightGrey,
                ),
              ),
            ),
          );
        }
      case ImageType.file:
        return Image.file(
          File(imagePath),
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          color: color,
        );
      case ImageType.networkMp4:
      case ImageType.mp4:
        return Container(
          color: AppColors.white,
          width: width,
          height: height,
          child: VideoPlayerItemWidget(
            videoUrl: imagePath,
            showControls: showControls,
            network: imagePath.imageType == ImageType.networkMp4,
            width: width,
            height: height,
            autoPlay: autoPlay,
          ),
        );
      case ImageType.empty:
        return Icon(Icons.image_outlined, color: color ?? AppColors.red);
      case ImageType.png:
      default:
        return Image.asset(
          imagePath,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          color: color,
        );
    }
  }
}

class VideoPlayerItemWidget extends StatefulWidget {
  final String videoUrl;
  final bool showControls;
  final bool autoPlay;
  final bool network;
  final double? height;
  final double? width;

  const VideoPlayerItemWidget({
    super.key,
    required this.videoUrl,
    required this.network,
    this.showControls = true,
    this.autoPlay = false,
    this.width,
    this.height,
  });

  @override
  State<VideoPlayerItemWidget> createState() => _VideoPlayerItemWidgetState();
}

class _VideoPlayerItemWidgetState extends State<VideoPlayerItemWidget> {
  late final VideoCubit _videoCubit;

  @override
  void initState() {
    super.initState();
    _videoCubit = VideoCubit(widget.videoUrl, widget.network, autoPlay: widget.autoPlay);
  }

  @override
  void dispose() {
    unawaited(_videoCubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _videoCubit,
      child: BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          return VideoPlayerItemBody(
            controller: _videoCubit.controller,
            isPlaying: state.isPlaying,
            showControls: widget.showControls,
            width: widget.width,
            height: widget.height,
          );
        },
      ),
    );
  }
}

class VideoPlayerItemBody extends StatelessWidget {
  final VideoPlayerController controller;
  final bool showControls;
  final bool isPlaying;
  final double? height;
  final double? width;

  const VideoPlayerItemBody({
    super.key,
    required this.controller,
    required this.showControls,
    required this.isPlaying,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: width,
            height: height,
            child: VideoPlayer(controller),
          ),
        ),
        if (showControls)
          Align(
            alignment: Alignment.center,
            child: VideoControls(
              isPlaying: isPlaying,
            ),
          ),
      ],
    );
  }
}

class VideoControls extends StatelessWidget {
  final bool isPlaying;

  const VideoControls({super.key, this.isPlaying = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoCubit, VideoState>(
      builder: (context, state) {
        return !isPlaying
            ? IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(.7),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: AppColors.white,
                  ),
                ),
                onPressed: () {
                  context.read<VideoCubit>().changeStatus(true);
                  context.read<VideoCubit>().play();
                },
              )
            : IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(.7),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Icon(
                    Icons.pause,
                    color: AppColors.white,
                  ),
                ),
                onPressed: () {
                  context.read<VideoCubit>().changeStatus(false);
                  context.read<VideoCubit>().pause();
                },
              );
      },
    );
  }
}
