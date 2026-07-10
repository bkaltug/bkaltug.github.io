import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../data/projects_data.dart';
import '../theme/palette.dart';
import '../theme/typography.dart';
import '../util/links.dart';
import 'glass.dart';
import 'hover_card.dart';

/// Grid card for a project. The whole card navigates to the project's own
/// detail page; the GitHub/Live buttons inside still open externally.
class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});

  final Project project;

  Color get _accent => project.type == ProjectType.software
      ? Palette.accentPurple
      : Palette.accentRed;

  IconData get _icon =>
      project.type == ProjectType.software ? Icons.code : Icons.memory;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    final imageAsset = project.imageAsset;
    final githubUrl = project.githubUrl;
    final liveUrl = project.liveUrl;
    final status = project.status;

    return HoverCard(
      accent: _accent,
      onTap: () => context.go(projectRoute(project)),
      semanticLabel: '${project.title} — view project details',
      builder: (context, hovered) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (imageAsset != null)
                  Image.asset(
                    imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _MediaPlaceholder(accent: _accent, icon: _icon),
                  )
                else
                  _MediaPlaceholder(accent: _accent, icon: _icon),
                if (status != null)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Palette.background.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: _accent.withValues(alpha: 0.45),
                        ),
                      ),
                      child: Text(
                        status,
                        style: AppType.chip(
                          size: 11.5,
                          color: Palette.textPrimary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.title, style: AppType.heading(size: 18)),
                const SizedBox(height: 8),
                Text(
                  project.description,
                  style: AppType.body(size: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final tech in project.tech) GlassChip(label: tech),
                  ],
                ),
                if (githubUrl != null || liveUrl != null) ...[
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      if (githubUrl != null)
                        OutlinedButton.icon(
                          onPressed: () => openExternal(githubUrl),
                          icon: const FaIcon(FontAwesomeIcons.github, size: 15),
                          label: const Text('GitHub'),
                        ),
                      if (liveUrl != null)
                        OutlinedButton.icon(
                          onPressed: () => openExternal(liveUrl),
                          icon: const Icon(Icons.open_in_new, size: 16),
                          label: const Text('Live'),
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: 16),
                AnimatedPadding(
                  duration: reduceMotion
                      ? Duration.zero
                      : const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.only(left: hovered ? 8 : 0),
                  child: Text(
                    'View project →',
                    style: AppType.chip(size: 13, color: _accent),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Diagonal accent gradient with a large faint icon — shown while a project
/// has no image asset.
class _MediaPlaceholder extends StatelessWidget {
  const _MediaPlaceholder({required this.accent, required this.icon});

  final Color accent;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent.withValues(alpha: 0.28),
            accent.withValues(alpha: 0.04),
          ],
        ),
      ),
      child: Center(
        child: Icon(icon, size: 88, color: accent.withValues(alpha: 0.20)),
      ),
    );
  }
}
