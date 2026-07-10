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

  test('resume data is present', () {
    expect(education, isNotEmpty);
    expect(skillGroups, hasLength(5));
    expect(experience, hasLength(2));
    for (final entry in experience) {
      expect(entry.bullets, hasLength(2));
    }
  });
}
