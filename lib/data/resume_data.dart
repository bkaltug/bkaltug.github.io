/// Content for the Education & Resume page. Edit freely — the layout adapts.
class EducationEntry {
  final String degree;
  final String school;
  final String location;


  final String? period;

  /// Optional, e.g. 'GPA 3.4 / 4.0'. Hidden while null.
  final String? gpa;

  /// One line about the senior/graduation project. Hidden while null.
  final String? projectLine;

  const EducationEntry({
    required this.degree,
    required this.school,
    required this.location,
    this.period,
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
    degree: 'High School Diploma',
    school: 'Bornova Anadolu Lisesi (BAL)',
    location: 'Izmir, Türkiye',
    gpa: null,
  ),
  EducationEntry(
    degree: 'B.Sc. Electronics & Communications Engineering',
    school: 'Izmir Institute of Technology (IZTECH)',
    location: 'Izmir, Türkiye',
    gpa: null,
    projectLine: 'Senior project: TBD',
  ),
];

const List<SkillGroup> skillGroups = [
  SkillGroup(
    label: 'Embedded & Hardware',
    skills: ['C / C++', 'Arduino', "Raspberry Pi", 'STM32', 'PCB Design'],
  ),

  SkillGroup(
    label: 'Communications & Signal Processing',
    skills: ['MATLAB', 'Quartus', 'Digital Signal Processing', 'Satellite Communications'],
  ),

  SkillGroup(
    label: 'AI & Machine Learning',
    skills: ['PyTorch', 'scikit-learn', 'Computer Vision', 'Natural Language Processing', 'Deep Learning', 'Neural Networks', 'Data Analysis', 'Data Visualization', 'TensorFlow', 'Keras', 'OpenCV', 'Pandas', 'NumPy', 'Matplotlib'],
  ),
  SkillGroup(
    label: 'Software & Tools',
    skills: ['Flutter', 'Dart', 'Python', 'Supabase', 'Git', 'VS Code'],
  ),
  SkillGroup(
    label: 'Languages',
    skills: ['Turkish - Native', 'English - C1', 'Italian - B1'],
  ),
];

const List<ExperienceEntry> experience = [
  // TODO(berkay): replace this placeholder with a real experience entry.
  ExperienceEntry(
    role: 'Mobile App Developer Intern',
    organization: 'RoofStacks',
    period: 'Aug 2023 - Sep 2023',
    bullets: [
      'Successfully completed my internship in RoofStacks as a Mobile Application Developer Intern',
      'Mainly worked with Kotlin',
      'Got into Android Development, Kotlin Coroutines, Android Jetpack Compose and had the time to apply and practice all of these technologies'
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
