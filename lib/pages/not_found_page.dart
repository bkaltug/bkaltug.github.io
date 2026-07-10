import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/typography.dart';

/// Minimal 404 page for unknown paths.
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('404', style: AppType.overline()),
              const SizedBox(height: 12),
              Text('Nothing here.', style: AppType.display(size: 32)),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => context.go('/'),
                child: const Text('Back home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
