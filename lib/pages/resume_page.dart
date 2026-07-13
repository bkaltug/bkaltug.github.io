import 'package:flutter/material.dart';

import '../data/resume_data.dart';
import '../theme/palette.dart';
import '../theme/typography.dart';
import '../util/links.dart';
import '../widgets/entrance.dart';
import '../widgets/glass.dart';
import '../widgets/page_top_bar.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PageTopBar(),
          Expanded(
            // SelectionArea so recruiters can copy any of the resume text.
            child: SelectionArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 72),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 860),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Entrance(child: _Header()),
                        const SizedBox(height: 44),
                        Entrance(
                          delayMs: 70,
                          child: _Section(
                            label: 'EDUCATION',
                            child: GlassPanel(
                              child: Column(
                                children: [
                                  for (var i = 0; i < education.length; i++)
                                    _TimelineEntry(
                                      isLast: i == education.length - 1,
                                      child: _EducationContent(
                                        entry: education[i],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),
                        Entrance(
                          delayMs: 210,
                          child: _Section(
                            label: 'EXPERIENCE',
                            child: GlassPanel(
                              child: Column(
                                children: [
                                  for (var i = 0; i < experience.length; i++)
                                    _TimelineEntry(
                                      isLast: i == experience.length - 1,
                                      child: _ExperienceContent(
                                        entry: experience[i],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),
                        Entrance(
                          delayMs: 140,
                          child: _Section(
                            label: 'SKILLS',
                            child: GlassPanel(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i = 0; i < skillGroups.length; i++) ...[
                                    if (i > 0) const SizedBox(height: 22),
                                    _SkillGroupView(group: skillGroups[i]),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 20,
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ABOUT', style: AppType.overline()),
            const SizedBox(height: 10),
            Text('Education & Resume', style: AppType.display(size: 36)),
          ],
        ),
        SizedBox(width: 300),
        FilledButton.icon(
          onPressed: () => openExternalUri(Uri.base.resolve('cv.pdf')),
          icon: const Icon(Icons.download, size: 18),
          label: const Text('Download CV (PDF)'),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Palette.accentBlue,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Text(label, style: AppType.overline()),
          ],
        ),
        const SizedBox(height: 18),
        child,
      ],
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({required this.isLast, required this.child});

  final bool isLast;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.background,
                  border: Border.all(color: Palette.accentBlue, width: 2),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.only(top: 6),
                    color: Palette.cardBorder,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 28),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class _EducationContent extends StatelessWidget {
  const _EducationContent({required this.entry});

  final EducationEntry entry;

  @override
  Widget build(BuildContext context) {
    final gpa = entry.gpa;
    final projectLine = entry.projectLine;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(entry.degree, style: AppType.heading(size: 18)),
        const SizedBox(height: 6),
        Text('${entry.school} · ${entry.location}', style: AppType.body(size: 14)),
        const SizedBox(height: 4),
        Text(entry.period ?? '', style: AppType.chip(size: 13)),
        if (gpa != null) ...[
          const SizedBox(height: 8),
          Text(gpa, style: AppType.body(size: 14)),
        ],
        if (projectLine != null) ...[
          const SizedBox(height: 8),
          Text(projectLine, style: AppType.body(size: 14)),
        ],
      ],
    );
  }
}

class _SkillGroupView extends StatelessWidget {
  const _SkillGroupView({required this.group});

  final SkillGroup group;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          group.label,
          style: AppType.body(
            size: 13.5,
            weight: FontWeight.w600,
            color: Palette.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [for (final skill in group.skills) GlassChip(label: skill)],
        ),
      ],
    );
  }
}

class _ExperienceContent extends StatelessWidget {
  const _ExperienceContent({required this.entry});

  final ExperienceEntry entry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(entry.role, style: AppType.heading(size: 17)),
        const SizedBox(height: 6),
        Text(
          '${entry.organization} · ${entry.period}',
          style: AppType.body(size: 14),
        ),
        const SizedBox(height: 10),
        for (final bullet in entry.bullets)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('•  ', style: AppType.body(size: 14)),
                Expanded(child: Text(bullet, style: AppType.body(size: 14))),
              ],
            ),
          ),
      ],
    );
  }
}
