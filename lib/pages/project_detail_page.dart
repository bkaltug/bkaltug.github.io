import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../data/projects_data.dart';
import '../theme/palette.dart';
import '../theme/typography.dart';
import '../util/links.dart';
import '../widgets/entrance.dart';
import '../widgets/glass.dart';
import '../widgets/page_top_bar.dart';
import '../widgets/video_embed.dart';
import 'not_found_page.dart';

/// Detail page for a single project (`/software/<slug>` or `/hardware/<slug>`).
/// Renders the project's [Project.sections] — text, images, videos — in order.
class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key, required this.type, required this.slug});

  final ProjectType type;
  final String slug;

  @override
  Widget build(BuildContext context) {
    final project = projectBySlug(type, slug);
    if (project == null) return const NotFoundPage();

    final accent = type == ProjectType.software
        ? Palette.accentPurple
        : Palette.accentRed;
    final overline = type == ProjectType.software
        ? 'SOFTWARE PROJECT'
        : 'HARDWARE PROJECT';
    final githubUrl = project.githubUrl;
    final liveUrl = project.liveUrl;
    final status = project.status;

    return Scaffold(
      body: Column(
        children: [
          PageTopBar(backTo: '/${type.name}'),
          Expanded(
            child: SelectionArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 72),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 860),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Entrance(
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: accent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(overline, style: AppType.overline()),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Entrance(
                          delayMs: 70,
                          child: Text(
                            project.title,
                            style: AppType.display(size: 34),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Entrance(
                          delayMs: 140,
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              if (status != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(
                                      color: accent.withValues(alpha: 0.45),
                                    ),
                                  ),
                                  child: Text(
                                    status,
                                    style: AppType.chip(
                                      color: Palette.textPrimary,
                                    ),
                                  ),
                                ),
                              for (final tech in project.tech)
                                GlassChip(label: tech),
                            ],
                          ),
                        ),
                        if (githubUrl != null || liveUrl != null) ...[
                          const SizedBox(height: 20),
                          Entrance(
                            delayMs: 210,
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 8,
                              children: [
                                if (githubUrl != null)
                                  OutlinedButton.icon(
                                    onPressed: () => openExternal(githubUrl),
                                    icon: const FaIcon(
                                      FontAwesomeIcons.github,
                                      size: 15,
                                    ),
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
                          ),
                        ],
                        const SizedBox(height: 36),
                        if (project.sections.isEmpty)
                          const Entrance(delayMs: 280, child: _EmptyDetail())
                        else
                          for (var i = 0; i < project.sections.length; i++) ...[
                            if (i > 0) const SizedBox(height: 32),
                            Entrance(
                              delayMs: math.min(280 + i * 70, 700),
                              child: _SectionView(
                                section: project.sections[i],
                                accent: accent,
                              ),
                            ),
                          ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyDetail extends StatelessWidget {
  const _EmptyDetail();

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(48),
      child: Column(
        children: [
          const Icon(
            Icons.auto_awesome,
            size: 34,
            color: Palette.textSecondary,
          ),
          const SizedBox(height: 14),
          Text(
            'More about this project is on the way — check back soon.',
            textAlign: TextAlign.center,
            style: AppType.body(size: 15, color: Palette.textPrimary),
          ),
        ],
      ),
    );
  }
}

class _SectionView extends StatelessWidget {
  const _SectionView({required this.section, required this.accent});

  final ProjectSection section;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return switch (section) {
      TextSection s => _TextView(section: s),
      ImageSection s => _ImageView(section: s),
      VideoSection s => _VideoView(section: s),
    };
  }
}

class _TextView extends StatelessWidget {
  const _TextView({required this.section});

  final TextSection section;

  @override
  Widget build(BuildContext context) {
    final heading = section.heading;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading != null) ...[
          Text(heading, style: AppType.heading(size: 20)),
          const SizedBox(height: 10),
        ],
        Text(section.body, style: AppType.body(size: 15, height: 1.7)),
      ],
    );
  }
}

class _MediaFrame extends StatelessWidget {
  const _MediaFrame({required this.child, this.caption});

  final Widget child;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final caption = this.caption;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Palette.cardBorder),
            color: Palette.cardFill,
          ),
          clipBehavior: Clip.antiAlias,
          child: child,
        ),
        if (caption != null) ...[
          const SizedBox(height: 10),
          Text(caption, style: AppType.body(size: 13)),
        ],
      ],
    );
  }
}

class _ImageView extends StatelessWidget {
  const _ImageView({required this.section});

  final ImageSection section;

  @override
  Widget build(BuildContext context) {
    final source = section.source;
    final isNetwork = source.startsWith('http');
    Widget errorPlaceholder(BuildContext context, Object error, StackTrace? stackTrace) =>
        Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            'Image not found: $source',
            textAlign: TextAlign.center,
            style: AppType.body(size: 13),
          ),
        );
    return _MediaFrame(
      caption: section.caption,
      child: isNetwork
          ? Image.network(
              source,
              width: double.infinity,
              fit: BoxFit.fitWidth,
              errorBuilder: errorPlaceholder,
            )
          : Image.asset(
              source,
              width: double.infinity,
              fit: BoxFit.fitWidth,
              errorBuilder: errorPlaceholder,
            ),
    );
  }
}

class _VideoView extends StatelessWidget {
  const _VideoView({required this.section});

  final VideoSection section;

  @override
  Widget build(BuildContext context) {
    return _MediaFrame(
      caption: section.caption,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoEmbed(source: section.source),
      ),
    );
  }
}
