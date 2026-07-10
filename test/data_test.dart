import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/data/profile_data.dart';
import 'package:portfolio/data/projects_data.dart';
import 'package:portfolio/data/resume_data.dart';

void main() {
  test('profile links are usable', () {
    expect(profile.name, isNotEmpty);
    expect(profile.githubUrl, startsWith('https://'));
    // Optional links may be null (their buttons hide) but never empty.
    expect(profile.linkedinUrl, isNot(''));
    expect(profile.email, isNot(''));
  });

  test('both project sections have well-formed entries', () {
    expect(projectsOfType(ProjectType.software), isNotEmpty);
    expect(projectsOfType(ProjectType.hardware), isNotEmpty);
    for (final project in projects) {
      expect(project.title, isNotEmpty);
      expect(project.description, isNotEmpty);
      expect(project.tech, isNotEmpty);
    }
  });

  test('project slugs are URL-safe and unique per type', () {
    final seen = <String>{};
    for (final project in projects) {
      expect(project.slug, matches(RegExp(r'^[a-z0-9-]+$')));
      expect(
        seen.add('${project.type.name}/${project.slug}'),
        isTrue,
        reason: 'duplicate slug: ${project.type.name}/${project.slug}',
      );
      expect(projectBySlug(project.type, project.slug), same(project));
    }
  });

  test('resume data is present', () {
    expect(education, isNotEmpty);
    expect(skillGroups, isNotEmpty);
    expect(experience, isNotEmpty);
    for (final entry in experience) {
      expect(entry.role, isNotEmpty);
      expect(entry.bullets, isNotEmpty);
    }
  });
}
