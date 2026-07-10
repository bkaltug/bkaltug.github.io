/// Content for the Education & Resume page. Edit freely — the layout adapts.
class EducationEntry {
  final String degree;
  final String school;
  final String location;
  final String period;

  /// Optional, e.g. 'GPA 3.4 / 4.0'. Hidden while null.
  final String? gpa;

  /// One line about the senior/graduation project. Hidden while null.
  final String? projectLine;

  const EducationEntry({
    required this.degree,
    required this.school,
    required this.location,
    required this.period,
    this.gpa,
    this.projectLine,
  });
}

class SkillGroup {
  final String label;
  final List<String> skills;

  const SkillGroup({required this.label, required this.skills});
}

class ExperienceEntry {
  final String role;
  final String organization;
  final String period;
  final List<String> bullets;

  const ExperienceEntry({
    required this.role,
    required this.organization,
    required this.period,
    required this.bullets,
  });
}

const List<EducationEntry> education = [
  EducationEntry(
    degree: 'B.Sc. Electronics & Communications Engineering',
    school: 'Izmir Institute of Technology (IZTECH)',
    location: 'Izmir, Türkiye',
    // TODO(berkay): fill in the real start/end years.
    period: '20XX – 2026',
    // TODO(berkay): add GPA if you want it shown, e.g. 'GPA 3.4 / 4.0'. Optional.
    gpa: null,
    // TODO(berkay): one line about your senior/graduation project.
    projectLine: 'Senior project: TODO — one line about the graduation project.',
  ),
];

const List<SkillGroup> skillGroups = [
  // TODO(berkay): confirm or replace these seeded chips — unverified skills
  // must not ship as fact.
  SkillGroup(
    label: 'Embedded & Hardware',
    skills: ['C / Embedded C', 'STM32', 'PCB Design'],
  ),
  // TODO(berkay): confirm or replace these seeded chips.
  SkillGroup(
    label: 'Communications & Signal Processing',
    skills: ['MATLAB', 'Digital Signal Processing', 'RF Fundamentals'],
  ),
  // TODO(berkay): confirm or replace these seeded chips.
  SkillGroup(
    label: 'AI & Machine Learning',
    skills: ['PyTorch', 'scikit-learn', 'Computer Vision'],
  ),
  SkillGroup(
    label: 'Software & Tools',
    skills: ['Flutter', 'Dart', 'Python', 'Supabase', 'Git', 'VS Code'],
  ),
  SkillGroup(
    label: 'Languages',
    skills: ['Turkish — Native', 'English — C1', 'Italian — B1'],
  ),
];

const List<ExperienceEntry> experience = [
  // TODO(berkay): replace this placeholder with a real experience entry.
  ExperienceEntry(
    role: 'Role title — TODO',
    organization: 'Organization — TODO',
    period: 'Dates — TODO',
    bullets: [
      'TODO(berkay): what you did and the impact it had.',
      'TODO(berkay): a second highlight worth a recruiter\'s time.',
    ],
  ),
  // TODO(berkay): replace this placeholder with a real experience entry.
  ExperienceEntry(
    role: 'Role title — TODO',
    organization: 'Organization — TODO',
    period: 'Dates — TODO',
    bullets: [
      'TODO(berkay): what you did and the impact it had.',
      'TODO(berkay): a second highlight worth a recruiter\'s time.',
    ],
  ),
];
