import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class TraceMediaThumbnail extends StatefulWidget {
  TraceMediaThumbnail({required this.media, required this.onRemove, this.radius = 120, super.key})
      : isVideo = MediaType.parse(lookupMimeType(media.path)!).type == 'video';

  final File media;
  final bool isVideo;
  final VoidCallback onRemove;
  final double radius;

  @override
  State<TraceMediaThumbnail> createState() => _TraceMediaThumbnailState();
}

class _TraceMediaThumbnailState extends State<TraceMediaThumbnail> {
  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      _generateVideoThumbnail();
    }
  }

  Uint8List? _videoThumbnail;

  Future<void> _generateVideoThumbnail() async {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: widget.media.path,
      imageFormat: ImageFormat.JPEG,
      quality: 90,
    );
    if (!mounted) return;
    setState(() {
      _videoThumbnail = thumbnail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipOval(
          child: SizedBox.square(
            dimension: widget.radius,
            child: switch (widget.isVideo) {
              true when _videoThumbnail == null => Center(child: CircularProgressIndicator()),
              true => Stack(
                  children: [
                    Image.memory(
                      _videoThumbnail!,
                      height: widget.radius,
                      width: widget.radius,
                      fit: BoxFit.cover,
                    ),
                    Icon(Icons.video_library),
                  ],
                ),
              false => Image.file(widget.media, height: widget.radius, width: widget.radius, fit: BoxFit.cover),
            },
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: Icon(Icons.close),
            visualDensity: VisualDensity.compact,
            iconSize: 32,
            padding: EdgeInsets.zero,
            onPressed: widget.onRemove,
          ),
        ),
      ],
    );
  }
}
