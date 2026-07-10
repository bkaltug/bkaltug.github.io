import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/palette.dart';
import '../theme/typography.dart';

/// 132px circular profile photo inside a 3px sweep-gradient ring
/// (red -> purple -> blue) that rotates slowly (~12s). Falls back to "BAU"
/// initials on a gradient disc while assets/images/profile.jpg is missing.
class AvatarRing extends StatefulWidget {
  const AvatarRing({super.key, this.size = 148});

  final double size;

  @override
  State<AvatarRing> createState() => _AvatarRingState();
}

class _AvatarRingState extends State<AvatarRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 12),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _controller.stop();
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
    final photoSize = widget.size - 16; // 3px ring + a small gap on each side
    return Semantics(
      label: 'Profile photo',
      image: true,
      child: AnimatedBuilder(
        animation: _controller,
        child: SizedBox.square(
          dimension: widget.size,
          child: Center(
            child: ClipOval(
              child: SizedBox.square(
                dimension: photoSize,
                child: Image.asset(
                  'assets/images/profile.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const _InitialsFallback(),
                ),
              ),
            ),
          ),
        ),
        builder: (context, child) => CustomPaint(
          painter: _RingPainter(rotation: _controller.value * 2 * math.pi),
          child: child,
        ),
      ),
    );
  }
}

class _InitialsFallback extends StatelessWidget {
  const _InitialsFallback();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Palette.accentRed,
            Palette.accentPurple,
            Palette.accentBlue,
          ],
        ),
      ),
      child: Center(
        child: Text(
          'BAU',
          style: AppType.display(size: 36, color: Colors.white),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.rotation});

  final double rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..shader = SweepGradient(
        colors: const [
          Palette.accentRed,
          Palette.accentPurple,
          Palette.accentBlue,
          Palette.accentRed,
        ],
        transform: GradientRotation(rotation),
      ).createShader(Offset.zero & size);
    canvas.drawCircle(
      size.center(Offset.zero),
      size.width / 2 - 1.5,
      paint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.rotation != rotation;
}
