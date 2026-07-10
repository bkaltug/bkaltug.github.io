import 'package:flutter/material.dart';

import '../theme/palette.dart';

/// Glass card with the shared hover treatment: 6px lift, border and outer
/// glow shifting to [accent] over 220ms. When [onTap] is set the whole card
/// is clickable and keyboard-activatable, with a visible focus ring.
///
/// [builder] receives the current hover state so children (like the landing
/// cards' arrow) can react to it.
class HoverCard extends StatefulWidget {
  const HoverCard({
    super.key,
    required this.accent,
    required this.builder,
    this.onTap,
    this.semanticLabel,
  });

  final Color accent;
  final Widget Function(BuildContext context, bool hovered) builder;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  late final FocusNode _focusNode = FocusNode(
    canRequestFocus: widget.onTap != null,
    skipTraversal: widget.onTap == null,
  );
  bool _hovered = false;
  bool _focused = false;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    final active = _hovered || _focused;
    final borderColor = active
        ? widget.accent.withValues(alpha: 0.65)
        : Palette.cardBorder;

    Widget card = AnimatedContainer(
      duration: reduceMotion ? Duration.zero : const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      transform: Matrix4.translationValues(
        0,
        _hovered && !reduceMotion ? -6 : 0,
        0,
      ),
      decoration: BoxDecoration(
        color: Palette.cardFill,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
        boxShadow: active
            ? [
                BoxShadow(
                  color: widget.accent.withValues(alpha: 0.20),
                  blurRadius: 36,
                  spreadRadius: 2,
                  offset: const Offset(0, 12),
                ),
              ]
            : const [],
      ),
      // Keyboard focus ring, drawn above the fill without affecting layout.
      foregroundDecoration: _focused
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Palette.textPrimary.withValues(alpha: 0.9),
                width: 2,
              ),
            )
          : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: widget.builder(context, _hovered),
      ),
    );

    card = FocusableActionDetector(
      focusNode: _focusNode,
      mouseCursor: widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      onShowHoverHighlight: (value) => setState(() => _hovered = value),
      onShowFocusHighlight: (value) => setState(() => _focused = value),
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            widget.onTap?.call();
            return null;
          },
        ),
      },
      child: card,
    );

    if (widget.onTap == null) return card;
    return Semantics(
      button: true,
      label: widget.semanticLabel,
      child: GestureDetector(onTap: widget.onTap, child: card),
    );
  }
}
