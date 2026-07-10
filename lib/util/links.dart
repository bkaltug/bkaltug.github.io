import 'package:url_launcher/url_launcher.dart';

/// Opens [url] in a new browser tab.
Future<void> openExternal(String url) => openExternalUri(Uri.parse(url));

/// Opens [uri] in a new browser tab.
Future<void> openExternalUri(Uri uri) async {
  await launchUrl(uri, webOnlyWindowName: '_blank');
}
