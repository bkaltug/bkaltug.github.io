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
    degree: 'High School',
    school: 'Bornova Anadolu Lisesi (BAL)',
    location: 'Izmir, Türkiye',
    gpa: null,
  ),
  EducationEntry(
    degree: 'B.Sc. Electronics & Communications Engineering',
    school: 'Izmir Institute of Technology (IZTECH)',
    location: 'Izmir, Türkiye',
    gpa: null,
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

  ExperienceEntry(
    role: 'Electrical & Electronics Intern ',
    organization: 'BorgWarner Inc. (Phinia)',
    period: 'Sep 2022 - Oct 2022',
    bullets: [
      'Successfully completed my internship as an Electrical & Electronics Engineer',
      'Worked with industry - scaled PLCs, Proprietary Programming Languages (especially with SIEMENS machines)',
      'Collaborated with the IT Department',
      'Had a chance to experience how big scaled systems work in an automotive factory'
    ],
  ),

  ExperienceEntry(
    role: 'Software Developer',
    organization: 'DC Academy',
    period: 'Nov 2021 - July 2022',
    bullets: [
      'Worked as a part of the mobile application team that developed a transportation application which includes crypto currencies using Dart and Flutter, while simultaneously working on Smart Contract Development, Website Development, Social Media Management, Project Planning and Team Management which improved both my technical and social skills in related areas',
      'My main focus was building the application', 
      'Took part in the planning phase of the app',
      'Worked on smart contracts using Solidity',
      'Designed and coded websites using WebFlow',
      'Had the role of Social Media Manager of the crypto project BoxingBoyzs Turkey branch',
      'Had the role of manager of the Crypto Trading team of DC Academy Turkey',
      'All of these areas taught and improved me in many ways, such as teamwork, communication skills, being a leader,team management, planning of a mobile application and taking major responsibilities',
    ],
  ),
];
