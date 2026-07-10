import 'package:flutter/material.dart';

import '../theme/palette.dart';
import '../theme/typography.dart';

/// Static glass surface (radius 20, 1px border) for non-interactive content.
class GlassPanel extends StatelessWidget {
  const GlassPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Palette.cardFill,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Palette.cardBorder),
      ),
      child: child,
    );
  }
}

/// Fully rounded chip for skills and tech tags.
class GlassChip extends StatelessWidget {
  const GlassChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Palette.cardFill,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Palette.cardBorder),
      ),
      child: Text(label, style: AppType.chip()),
    );
  }
}
