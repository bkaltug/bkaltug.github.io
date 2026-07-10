import 'package:flutter/material.dart';

/// Staggered entrance: fades in while sliding up 12px (250ms, easeOutCubic).
/// Renders the child immediately when the platform requests reduced motion.
class Entrance extends StatefulWidget {
  const Entrance({super.key, required this.child, this.delayMs = 0});

  final Widget child;
  final int delayMs;

  @override
  State<Entrance> createState() => _EntranceState();
}

class _EntranceState extends State<Entrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );
  bool _scheduled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_scheduled) return;
    _scheduled = true;
    if (MediaQuery.of(context).disableAnimations) {
      _controller.value = 1;
    } else if (widget.delayMs == 0) {
      _controller.forward();
    } else {
      Future<void>.delayed(Duration(milliseconds: widget.delayMs), () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final v = Curves.easeOutCubic.transform(_controller.value);
        return Opacity(
          opacity: v,
          child: Transform.translate(
            offset: Offset(0, 12 * (1 - v)),
            child: child,
          ),
        );
      },
    );
  }
}
