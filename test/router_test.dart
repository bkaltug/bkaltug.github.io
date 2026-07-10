import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/router.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('all four routes resolve', () {
    for (final path in ['/', '/resume', '/software', '/hardware']) {
      final match = router.configuration.findMatch(Uri.parse(path));
      expect(match.isError, isFalse, reason: path);
      expect(match.matches, isNotEmpty, reason: path);
    }
  });

  test('unknown paths hit the in-shell 404 catch-all', () {
    for (final path in ['/nope', '/definitely/not/here']) {
      final match = router.configuration.findMatch(Uri.parse(path));
      expect(match.isError, isFalse, reason: path);
      expect(match.matches, isNotEmpty, reason: path);
    }
  });
}
