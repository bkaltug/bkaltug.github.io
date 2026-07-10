import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'router.dart';
import 'theme/app_theme.dart';

void main() {
  // Clean URLs (no #) — GitHub Pages deep links survive refresh via the
  // 404.html fallback created by the deploy workflow.
  usePathUrlStrategy();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Berkay Altuğ Ustagül — Electronics & Communications Engineer',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: router,
    );
  }
}
