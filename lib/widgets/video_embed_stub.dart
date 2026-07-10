import 'package:flutter/widgets.dart';

/// Non-web fallback (used by VM tests); the site itself is web-only.
Widget buildVideoEmbed(String source) => const SizedBox.shrink();
