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
        'Cross-platform app for tracking movies, TV series, books, and games '
        'in one unified library.',
    tech: ['Flutter', 'Dart', 'Supabase', 'PostgreSQL', 'REST APIs'],
    githubUrl: 'https://github.com/bkaltug/HobbyHub',
    status: 'In development',
    type: ProjectType.software,
  ),
  // TODO(berkay): replace this placeholder with a real software project.
  Project(
    title: 'Software Project — TODO',
    description:
        'TODO(berkay): one or two sentences on what this project does and why '
        'it is interesting.',
    tech: ['TODO'],
    type: ProjectType.software,
  ),
  // TODO(berkay): replace this placeholder with a real software project.
  Project(
    title: 'Software Project — TODO',
    description:
        'TODO(berkay): one or two sentences on what this project does and why '
        'it is interesting.',
    tech: ['TODO'],
    type: ProjectType.software,
  ),

  // ---- Hardware -----------------------------------------------------------
  // TODO(berkay): replace this placeholder with your FPGA project.
  Project(
    title: 'FPGA Project — TODO',
    description:
        'TODO(berkay): one or two sentences on the FPGA work — platform, '
        'toolchain, what it achieved.',
    tech: ['TODO'],
    type: ProjectType.hardware,
  ),
  // TODO(berkay): replace this placeholder with your embedded systems project.
  Project(
    title: 'Embedded Systems Project — TODO',
    description:
        'TODO(berkay): one or two sentences on the embedded work — MCU, '
        'peripherals, what it achieved.',
    tech: ['TODO'],
    type: ProjectType.hardware,
  ),
  // TODO(berkay): replace this placeholder with your senior design project.
  Project(
    title: 'Senior Design Project — TODO',
    description:
        'TODO(berkay): one or two sentences on the senior design project and '
        'its outcome.',
    tech: ['TODO'],
    type: ProjectType.hardware,
  ),
];

List<Project> projectsOfType(ProjectType type) =>
    projects.where((p) => p.type == type).toList();
