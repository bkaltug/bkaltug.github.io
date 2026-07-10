import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../theme/palette.dart';

/// Fullscreen animated "Aurora Noir" backdrop: three drifting diagonal light
/// beams over the base color, a corner vignette, and — on desktop widths — a
/// faint purple glow that follows the cursor.
///
/// Rendered once behind every page by the router shell (inside a
/// [RepaintBoundary]) so it never restarts across navigation and content
/// widgets never rebuild while it animates.
class AuroraBackground extends StatefulWidget {
  const AuroraBackground({super.key, this.cursor});

  /// Latest pointer position in global coordinates; null until first hover.
  final ValueListenable<Offset?>? cursor;

  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 28),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      // Reduced motion: hold a pleasant static frame instead of drifting.
      _controller.stop();
      _controller.value = 0.3;
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 1100;
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Palette.background),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => CustomPaint(
            willChange: true,
            painter: _BeamsPainter(t: _controller.value),
          ),
        ),
        // Subtle vignette above the beams so the corners stay dark.
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 1.2,
              colors: [Color(0x00000000), Color(0x59000000)],
              stops: [0.55, 1.0],
            ),
          ),
        ),
        if (widget.cursor != null && isDesktop)
          _CursorGlow(cursor: widget.cursor!),
      ],
    );
  }
}

class _CursorGlow extends StatelessWidget {
  const _CursorGlow({required this.cursor});

  final ValueListenable<Offset?> cursor;

  static const double _radius = 340;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Offset?>(
      valueListenable: cursor,
      child: const IgnorePointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Color(0x0F9A5CFF), Color(0x009A5CFF)],
            ),
          ),
          child: SizedBox.square(dimension: _radius * 2),
        ),
      ),
      builder: (context, position, child) {
        if (position == null) return const SizedBox.shrink();
        return Positioned(
          left: position.dx - _radius,
          top: position.dy - _radius,
          child: child!,
        );
      },
    );
  }
}

class _BeamSpec {
  const _BeamSpec({
    required this.color,
    required this.opacity,
    required this.thickness,
    required this.cx,
    required this.cy,
    required this.baseAngle,
    required this.phase,
    required this.driftX,
    required this.driftY,
    required this.angleAmp,
  });

  final Color color;
  final double opacity;
  final double thickness;
  final double cx; // center x as a fraction of width
  final double cy; // center y as a fraction of height
  final double baseAngle; // radians
  final double phase; // per-beam phase offset so motion never syncs up
  final double driftX; // drift amplitude, fraction of width
  final double driftY; // drift amplitude, fraction of height
  final double angleAmp; // angle sway amplitude, radians
}

class _BeamsPainter extends CustomPainter {
  const _BeamsPainter({required this.t});

  /// Controller value in [0, 1]; all motion uses sin/cos of whole multiples
  /// of 2*pi*t so the 28s loop is seamless.
  final double t;

  static const List<_BeamSpec> _beams = [
    _BeamSpec(
      color: Palette.accentRed,
      opacity: 0.12,
      thickness: 320,
      cx: 0.20,
      cy: 0.22,
      baseAngle: -0.52,
      phase: 0.0,
      driftX: 0.10,
      driftY: 0.05,
      angleAmp: 0.05,
    ),
    _BeamSpec(
      color: Palette.accentBlue,
      opacity: 0.11,
      thickness: 420,
      cx: 0.78,
      cy: 0.58,
      baseAngle: -0.40,
      phase: 2.09,
      driftX: 0.08,
      driftY: 0.07,
      angleAmp: 0.04,
    ),
    _BeamSpec(
      color: Palette.accentPurple,
      opacity: 0.14,
      thickness: 230,
      cx: 0.48,
      cy: 0.86,
      baseAngle: -0.62,
      phase: 4.19,
      driftX: 0.12,
      driftY: 0.04,
      angleAmp: 0.06,
    ),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final wave = 2 * math.pi * t;
    for (final beam in _beams) {
      final cx =
          size.width * beam.cx +
          size.width * beam.driftX * math.sin(wave + beam.phase);
      final cy =
          size.height * beam.cy +
          size.height * beam.driftY * math.cos(2 * wave + beam.phase);
      final angle = beam.baseAngle + beam.angleAmp * math.sin(wave + beam.phase * 1.6);

      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: size.width * 1.5,
        height: beam.thickness,
      );
      final paint = Paint()
        // Soft ends come from the gradient fading to transparent; a bounded
        // per-shape blur (sigma <= 30, not a fullscreen ImageFilter) softens
        // the long edges.
        ..shader = LinearGradient(
          colors: [
            beam.color.withValues(alpha: 0),
            beam.color.withValues(alpha: beam.opacity),
            beam.color.withValues(alpha: 0),
          ],
        ).createShader(rect)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 28);

      canvas
        ..save()
        ..translate(cx, cy)
        ..rotate(angle)
        ..drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(beam.thickness / 2)),
          paint,
        )
        ..restore();
    }
  }

  @override
  bool shouldRepaint(_BeamsPainter oldDelegate) => oldDelegate.t != t;
}
