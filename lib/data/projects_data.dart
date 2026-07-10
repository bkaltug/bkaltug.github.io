/// Project cards for /software and /hardware, plus the content of each
/// project's own detail page. Edit this file to add, remove, or reorder
/// projects — the grids and detail pages adapt automatically.
///
/// Every project lives at `/<type>/<slug>` (e.g. /software/hobbyhub). Its
/// detail page renders [Project.sections] top to bottom; mix text, images,
/// and videos in any order:
///
///   sections: [
///     TextSection(heading: 'Overview', body: 'What the project is...'),
///     ImageSection(
///       source: 'assets/images/myproject_1.png', // or an https:// URL
///       caption: 'Optional caption under the image.',
///     ),
///     VideoSection(
///       source: 'https://www.youtube.com/watch?v=XXXXXXXXXXX', // YouTube
///       // or a direct .mp4: 'assets/videos/demo.mp4' / https URL
///       caption: 'Optional caption under the video.',
///     ),
///   ],
///
/// Asset images/videos must live under assets/ and be declared in
/// pubspec.yaml (assets/images/ already is).
enum ProjectType { software, hardware }

/// Building blocks for a project detail page.
sealed class ProjectSection {
  const ProjectSection();
}

/// A paragraph of text with an optional heading.
class TextSection extends ProjectSection {
  final String? heading;
  final String body;

  const TextSection({this.heading, required this.body});
}

/// An image: asset path (e.g. 'assets/images/x.png') or https URL.
class ImageSection extends ProjectSection {
  final String source;
  final String? caption;

  const ImageSection({required this.source, this.caption});
}

/// A video: YouTube link, or a direct .mp4 asset path / https URL.
class VideoSection extends ProjectSection {
  final String source;
  final String? caption;

  const VideoSection({required this.source, this.caption});
}

class Project {
  final String title;

  /// URL segment of the detail page: lowercase letters, digits, hyphens.
  /// Must be unique within the project's type.
  final String slug;
  final String description;
  final List<String> tech;
  final String? githubUrl;
  final String? liveUrl;

  /// Optional 16:9 card image under assets/ (declare it in pubspec.yaml).
  /// While null the card shows an accent gradient placeholder instead.
  final String? imageAsset;

  /// Optional status pill, e.g. 'In development'.
  final String? status;
  final ProjectType type;

  /// Detail page content, rendered in order. While empty the detail page
  /// shows a friendly "more soon" placeholder.
  final List<ProjectSection> sections;

  const Project({
    required this.title,
    required this.slug,
    required this.description,
    required this.tech,
    this.githubUrl,
    this.liveUrl,
    this.imageAsset,
    this.status,
    required this.type,
    this.sections = const [],
  });
}

const List<Project> projects = [
  // ---- Software -----------------------------------------------------------
  Project(
    title: 'HobbyHub',
    slug: 'hobbyhub',
    description:
        'Cross-platform app for tracking movies, TV series, books, and games '
        'in one unified library.',
    tech: ['Flutter', 'Dart', 'Supabase', 'PostgreSQL', 'REST APIs'],
    githubUrl: 'https://github.com/bkaltug/HobbyHub',
    status: 'In development',
    type: ProjectType.software,
    sections: [
      TextSection(
        heading: 'Overview',
        body:
            'HobbyHub keeps every hobby in one place: movies, TV series, '
            'books, and games live in a single unified library instead of '
            'four separate tracker apps. Built with Flutter on a Supabase '
            '(PostgreSQL) backend.',
      ),
      // TODO(berkay): add screenshots and a demo video here, e.g.
      // ImageSection(source: 'assets/images/hobbyhub_library.png',
      //     caption: 'The unified library view.'),
      // VideoSection(source: 'https://www.youtube.com/watch?v=XXXXXXXXXXX',
      //     caption: 'Two-minute walkthrough.'),
      TextSection(
        heading: 'Status',
        body:
            'In active development. '
            'TODO(berkay): describe current progress and planned features.',
      ),
    ],
  ),
  // TODO(berkay): replace this placeholder with a real software project.
  Project(
    title: 'Software Project — TODO',
    slug: 'software-project-2',
    description:
        'TODO(berkay): one or two sentences on what this project does and why '
        'it is interesting.',
    tech: ['TODO'],
    type: ProjectType.software,
  ),
  // TODO(berkay): replace this placeholder with a real software project.
  Project(
    title: 'Software Project — TODO',
    slug: 'software-project-3',
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
    slug: 'fpga-project',
    description:
        'TODO(berkay): one or two sentences on the FPGA work — platform, '
        'toolchain, what it achieved.',
    tech: ['TODO'],
    type: ProjectType.hardware,
  ),
  // TODO(berkay): replace this placeholder with your embedded systems project.
  Project(
    title: 'Embedded Systems Project — TODO',
    slug: 'embedded-project',
    description:
        'TODO(berkay): one or two sentences on the embedded work — MCU, '
        'peripherals, what it achieved.',
    tech: ['TODO'],
    type: ProjectType.hardware,
  ),
  // TODO(berkay): replace this placeholder with your senior design project.
  Project(
    title: 'Senior Design Project — TODO',
    slug: 'senior-design-project',
    description:
        'TODO(berkay): one or two sentences on the senior design project and '
        'its outcome.',
    tech: ['TODO'],
    type: ProjectType.hardware,
  ),
];

List<Project> projectsOfType(ProjectType type) =>
    projects.where((p) => p.type == type).toList();

Project? projectBySlug(ProjectType type, String slug) {
  for (final project in projects) {
    if (project.type == type && project.slug == slug) return project;
  }
  return null;
}

/// Route of a project's detail page, e.g. '/software/hobbyhub'.
String projectRoute(Project project) => '/${project.type.name}/${project.slug}';
