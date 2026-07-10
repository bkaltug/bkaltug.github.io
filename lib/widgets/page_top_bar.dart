import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/profile_data.dart';
import '../theme/palette.dart';
import '../theme/typography.dart';

/// Slim top bar for subpages: back arrow + wordmark.
/// The landing page has no top bar.
class PageTopBar extends StatelessWidget {
  const PageTopBar({super.key, this.backTo = '/'});

  /// Where the back arrow navigates; defaults to the landing page.
  final String backTo;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => context.go(backTo),
                  tooltip: backTo == '/' ? 'Back to home' : 'Back',
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Palette.textPrimary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Text(profile.name, style: AppType.heading(size: 15)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
