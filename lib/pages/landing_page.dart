import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../data/profile_data.dart';
import '../theme/palette.dart';
import '../theme/typography.dart';
import '../util/links.dart';
import '../widgets/avatar_ring.dart';
import '../widgets/entrance.dart';
import '../widgets/hover_card.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final nameSize = (constraints.maxWidth * 0.055).clamp(34.0, 56.0);
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 48,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1100),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Entrance(
                          child: Text('MY PORTFOLIO', style: AppType.overline()),
                        ),
                        const SizedBox(height: 28),
                        const Entrance(delayMs: 70, child: AvatarRing()),
                        const SizedBox(height: 28),
                        Entrance(
                          delayMs: 140,
                          child: Text(
                            profile.name.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: AppType.display(size: nameSize),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Entrance(
                          delayMs: 210,
                          child: Column(
                            children: [
                              Text(
                                profile.headline,
                                textAlign: TextAlign.center,
                                style: AppType.body(
                                  size: 17,
                                  weight: FontWeight.w500,
                                  color: Palette.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                profile.tagline,
                                textAlign: TextAlign.center,
                                style: AppType.body(size: 14),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 44),
                        Entrance(
                          delayMs: 280,
                          child: const _NavCards(),
                        ),
                        const SizedBox(height: 52),
                        const Entrance(delayMs: 350, child: _Footer()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NavCards extends StatelessWidget {
  const _NavCards();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        const gap = 20.0;
        final double cardWidth;
        if (w >= 1050) {
          cardWidth = (w - 2 * gap) / 3; // one row of three
        } else if (w >= 620) {
          cardWidth = (w - gap) / 2; // wraps 2 + 1
        } else {
          cardWidth = w; // single full-width column
        }
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final card in _cards)
              SizedBox(width: cardWidth, child: _NavCard(spec: card)),
          ],
        );
      },
    );
  }

  static const List<_NavCardSpec> _cards = [
    _NavCardSpec(
      title: 'Education & Resume',
      description: 'Degree, skills, and experience at a glance.',
      icon: Icons.school_outlined,
      accent: Palette.accentBlue,
      route: '/resume',
    ),
    _NavCardSpec(
      title: 'Software Projects',
      description: 'Apps and tools I\'ve designed and built.',
      icon: Icons.code,
      accent: Palette.accentPurple,
      route: '/software',
    ),
    _NavCardSpec(
      title: 'Hardware Projects',
      description: 'Electronics, FPGA, and embedded work.',
      icon: Icons.memory,
      accent: Palette.accentRed,
      route: '/hardware',
    ),
  ];
}

class _NavCardSpec {
  const _NavCardSpec({
    required this.title,
    required this.description,
    required this.icon,
    required this.accent,
    required this.route,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color accent;
  final String route;
}

class _NavCard extends StatelessWidget {
  const _NavCard({required this.spec});

  final _NavCardSpec spec;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    return HoverCard(
      accent: spec.accent,
      onTap: () => context.go(spec.route),
      semanticLabel: '${spec.title} — ${spec.description}',
      builder: (context, hovered) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: spec.accent.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(spec.icon, color: spec.accent, size: 22),
            ),
            const SizedBox(height: 16),
            Text(spec.title, style: AppType.heading(size: 19)),
            const SizedBox(height: 6),
            Text(
              spec.description,
              style: AppType.body(size: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 18),
            AnimatedPadding(
              duration: reduceMotion
                  ? Duration.zero
                  : const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.only(left: hovered ? 8 : 0),
              child: Text(
                '→',
                style: AppType.heading(size: 18, color: spec.accent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final linkedinUrl = profile.linkedinUrl;
    final email = profile.email;
    return Column(
      children: [
        Wrap(
          spacing: 12,
          alignment: WrapAlignment.center,
          children: [
            _CircleIconButton(
              tooltip: 'GitHub',
              icon: const FaIcon(FontAwesomeIcons.github, size: 18),
              onPressed: () => openExternal(profile.githubUrl),
            ),
            if (linkedinUrl != null)
              _CircleIconButton(
                tooltip: 'LinkedIn',
                icon: const FaIcon(FontAwesomeIcons.linkedinIn, size: 18),
                onPressed: () => openExternal(linkedinUrl),
              ),
            if (email != null)
              _CircleIconButton(
                tooltip: 'Email',
                icon: const Icon(Icons.mail_outline, size: 20),
                onPressed: () => openExternal('mailto:$email'),
              ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          '© 2026 ${profile.name}',
          textAlign: TextAlign.center,
          style: AppType.body(size: 13),
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: icon,
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(46, 46)),
        shape: const WidgetStatePropertyAll(CircleBorder()),
        overlayColor: const WidgetStatePropertyAll(Color(0x14FFFFFF)),
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.hovered) ||
                  states.contains(WidgetState.focused)
              ? Palette.textPrimary
              : Palette.textSecondary,
        ),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return const BorderSide(color: Palette.textPrimary, width: 1.5);
          }
          if (states.contains(WidgetState.hovered)) {
            return const BorderSide(color: Color(0x40FFFFFF));
          }
          return const BorderSide(color: Palette.cardBorder);
        }),
      ),
    );
  }
}
