import 'package:flutter/material.dart';

import 'video_embed_stub.dart'
    if (dart.library.js_interop) 'video_embed_web.dart' as impl;

/// Inline video player for project pages. [source] may be a YouTube link
/// (rendered as an embed) or a direct .mp4 — either an asset path like
/// 'assets/videos/demo.mp4' or an https URL — rendered as a native HTML5
/// video with browser controls.
class VideoEmbed extends StatelessWidget {
  const VideoEmbed({super.key, required this.source});

  final String source;

  @override
  Widget build(BuildContext context) => impl.buildVideoEmbed(source);
}
