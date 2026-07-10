/// Project cards for /software and /hardware. Edit this file to add, remove,
/// or reorder projects — the grids adapt automatically.
enum ProjectType { software, hardware }

class Project {
  final String title;
  final String description;
  final List<String> tech;
  final String? githubUrl;
  final String? liveUrl;

  /// Optional 16:9 image under assets/ (declare it in pubspec.yaml). While
  /// null the card shows an accent gradient placeholder instead.
  final String? imageAsset;

  /// Optional status pill, e.g. 'In development'.
  final String? status;
  final ProjectType type;

  const Project({
    required this.title,
    required this.description,
    required this.tech,
    this.githubUrl,
    this.liveUrl,
    this.imageAsset,
    this.status,
    required this.type,
  });
}

const List<Project> projects = [
  // ---- Software -----------------------------------------------------------
  Project(
    title: 'HobbyHub',
    description:
        'Cross-platform app for tracking hobbies'
        'in one unified library.',
    tech: ['Flutter', 'Dart', 'Supabase', 'PostgreSQL', 'REST APIs'],
    githubUrl: 'https://github.com/bkaltug/HobbyHub',
    status: 'In development',
    type: ProjectType.software,
  ),
  Project(
    title: 'Foody',
    description:
        'An app that gives you a recipe based on the picture of ingredients.',
    tech: ['Flutter', 'Dart', 'Python', 'Computer vision'],
    type: ProjectType.software,
  ),
  Project(
    title: 'TS Vision',
    description:
        'An app that detects traffic signs in real-time with computer vision',
    tech: ['Flutter', 'Dart', 'Python', 'Computer Vision'],
    type: ProjectType.software,
  ),

  // ---- Hardware -----------------------------------------------------------
  Project(
    title: '2 - bit PWM Encoder & Decoder',
    description:
        'A circuit that is able to communicate in 2 bits using PWM signals. ',
    tech: ['LTSPice', 'Circuit Design'],
    type: ProjectType.hardware,
  ),
  Project(
    title: 'Automatic Pet Feeder',
    description:
        'A system that utilizes sensors and a robotic arm to act as an automatic pet feeder.',
    tech: ['Arduino Mega 2560', 'Servo Motors', 'Ultrasonic Sensor', 'Weight Sensor', 'Robotic Arm'],
    type: ProjectType.hardware,
  ),
  Project(
    title: 'CanSat - Can Sized Satellite',
    description:
        'The model satellite prepared for the TEKNOFEST Model Uydu (CanSat) competition. ',
    tech: ['Raspberry Pi 2w Zero', 'Arduino', 'Sensors', 'C++', 'Python'],
    type: ProjectType.hardware,
  ),
];

List<Project> projectsOfType(ProjectType type) =>
    projects.where((p) => p.type == type).toList();
