import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

final Set<String> _registeredViewTypes = <String>{};

/// Renders [source] as a native HTML element: an iframe embed for YouTube
/// links, otherwise an HTML5 `<video>` with the browser's built-in controls.
Widget buildVideoEmbed(String source) {
  final viewType = 'video-embed:$source';
  if (_registeredViewTypes.add(viewType)) {
    final youTubeUrl = _youTubeEmbedUrl(source);
    ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      if (youTubeUrl != null) {
        return web.HTMLIFrameElement()
          ..src = youTubeUrl
          ..allow =
              'accelerometer; autoplay; clipboard-write; encrypted-media; '
              'gyroscope; picture-in-picture; web-share'
          ..allowFullscreen = true
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%';
      }
      return web.HTMLVideoElement()
        ..src = _resolveVideoSrc(source)
        ..controls = true
        ..preload = 'metadata'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'contain'
        ..style.backgroundColor = '#000000';
    });
  }
  return HtmlElementView(viewType: viewType);
}

/// Extracts a YouTube video id from watch/short/share/embed URLs and returns
/// the privacy-enhanced embed URL, or null when [url] is not a YouTube link.
String? _youTubeEmbedUrl(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null || !url.startsWith('http')) return null;
  final host = uri.host.replaceFirst('www.', '');
  String? id;
  if (host == 'youtu.be') {
    id = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
  } else if (host == 'youtube.com' || host == 'youtube-nocookie.com') {
    final segments = uri.pathSegments;
    if (segments.isNotEmpty &&
        (segments.first == 'embed' || segments.first == 'shorts')) {
      id = segments.length > 1 ? segments[1] : null;
    } else {
      id = uri.queryParameters['v'];
    }
  }
  if (id == null || id.isEmpty) return null;
  return 'https://www.youtube-nocookie.com/embed/$id';
}

String _resolveVideoSrc(String source) {
  if (source.startsWith('http://') || source.startsWith('https://')) {
    return source;
  }
  // Flutter asset key (e.g. 'assets/videos/demo.mp4') — served under assets/.
  return 'assets/$source';
}
