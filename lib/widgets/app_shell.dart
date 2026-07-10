import 'package:flutter/material.dart';

import 'aurora_background.dart';

/// Router shell: keeps one persistent [AuroraBackground] under every page so
/// the animation never restarts across navigation, and feeds it the cursor
/// position for the desktop-only glow.
class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final ValueNotifier<Offset?> _cursor = ValueNotifier<Offset?>(null);

  @override
  void dispose() {
    _cursor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      onHover: (event) => _cursor.value = event.position,
      child: Stack(
        children: [
          Positioned.fill(
            child: RepaintBoundary(child: AuroraBackground(cursor: _cursor)),
          ),
          widget.child,
        ],
      ),
    );
  }
}
