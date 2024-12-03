import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/models/trace_type.dart';

class TraceMedia extends StatelessWidget {
  const TraceMedia({required this.mediaUrl, required this.type, super.key});

  final String mediaUrl;
  final TraceType type;

  @override
  Widget build(BuildContext context) {
    return type == TraceType.video ? _Video(videoUrl: mediaUrl) : _Image(imageUrl: mediaUrl);
  }
}

class _Image extends StatelessWidget {
  const _Image({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: BorderRadius.circular(24), child: CachedNetworkImage(imageUrl: imageUrl));
  }
}

class _Video extends StatefulWidget {
  const _Video({required this.videoUrl});

  final String videoUrl;

  @override
  State<_Video> createState() => _VideoState();
}

class _VideoState extends State<_Video> {
  late final CachedVideoPlayerPlusController _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    _controller = CachedVideoPlayerPlusController.networkUrl(
      Uri.parse(widget.videoUrl),
      invalidateCacheIfOlderThan: const Duration(days: 7),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    await _controller.initialize();
    if (!mounted) return;
    await _controller.play();
    if (!mounted) return;
    await _controller.setLooping(true);
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const CircularProgressIndicator();
    }
    if (_controller.value.rotationCorrection == 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: CachedVideoPlayerPlus(_controller),
        ),
      );
    }
    return Transform.scale(
      scale: 0.55,
      child: AspectRatio(
        aspectRatio: 1 / _controller.value.aspectRatio,
        child: FittedBox(
          fit: BoxFit.cover,
          child: ClipRect(
            clipper: const _VideoClipper(),
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                height: _controller.value.size.height,
                width: _controller.value.size.width,
                child: CachedVideoPlayerPlus(_controller),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _VideoClipper extends CustomClipper<Rect> {
  const _VideoClipper();

  @override
  Rect getClip(Size size) => Rect.fromCenter(center: size.center(Offset.zero), width: size.height, height: size.width);

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}
