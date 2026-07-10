import 'package:flutter/material.dart';

import '../data/projects_data.dart';
import '../theme/palette.dart';
import '../theme/typography.dart';
import '../widgets/entrance.dart';
import '../widgets/glass.dart';
import '../widgets/page_top_bar.dart';
import '../widgets/project_card.dart';

/// Shared page for /software and /hardware.
class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key, required this.type});

  final ProjectType type;

  Color get _accent =>
      type == ProjectType.software ? Palette.accentPurple : Palette.accentRed;

  String get _title =>
      type == ProjectType.software ? 'Software Projects' : 'Hardware Projects';

  @override
  Widget build(BuildContext context) {
    final items = projectsOfType(type);
    return Scaffold(
      body: Column(
        children: [
          const PageTopBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 72),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
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
                                color: _accent,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text('PROJECTS', style: AppType.overline()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Entrance(
                        delayMs: 70,
                        child: Text(_title, style: AppType.display(size: 36)),
                      ),
                      const SizedBox(height: 30),
                      if (items.isEmpty)
                        const Entrance(delayMs: 140, child: _EmptyState())
                      else
                        _ProjectsGrid(items: items),
                    ],
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

class _ProjectsGrid extends StatelessWidget {
  const _ProjectsGrid({required this.items});

  final List<Project> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        const gap = 20.0;
        final int columns;
        if (w >= 1050) {
          columns = 3;
        } else if (w >= 620) {
          columns = 2;
        } else {
          columns = 1;
        }
        final cardWidth = (w - (columns - 1) * gap) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (var i = 0; i < items.length; i++)
              SizedBox(
                width: cardWidth,
                child: Entrance(
                  delayMs: 140 + i * 70,
                  child: ProjectCard(project: items[i]),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

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
            'Projects are on the way — check back soon.',
            textAlign: TextAlign.center,
            style: AppType.body(size: 15, color: Palette.textPrimary),
          ),
        ],
      ),
    );
  }
}
