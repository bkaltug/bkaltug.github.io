/// Site owner identity & links. Edit this file to update the whole site.
class Profile {
  final String name;
  final String headline;
  final String tagline;
  final String location;
  final String githubUrl;

  /// While null, the LinkedIn footer button stays hidden.
  final String? linkedinUrl;

  /// While null, the email footer button stays hidden.
  final String? email;

  const Profile({
    required this.name,
    required this.headline,
    required this.tagline,
    required this.location,
    required this.githubUrl,
    this.linkedinUrl,
    this.email,
  });
}

const Profile profile = Profile(
  name: 'Berkay Altuğ Ustagül',
  headline: 'Electronics & Communications Engineer',
  tagline: 'Embedded Systems • FPGA • Satellite Communications • AI • Flutter',
  location: 'İzmir, Türkiye',
  githubUrl: 'https://github.com/bkaltug',
  // TODO(berkay): add your LinkedIn URL, e.g. 'https://www.linkedin.com/in/<handle>'.
  linkedinUrl: null,
  // TODO(berkay): add your contact email, e.g. 'name@example.com'.
  email: null,
);
