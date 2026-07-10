import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data/projects_data.dart';
import 'pages/landing_page.dart';
import 'pages/not_found_page.dart';
import 'pages/projects_page.dart';
import 'pages/resume_page.dart';
import 'widgets/app_shell.dart';

CustomTransitionPage<void> _fadePage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
          opacity: animation.drive(CurveTween(curve: Curves.easeOutCubic)),
          child: child,
        ),
  );
}

final GoRouter router = GoRouter(
  routes: [
    ShellRoute(
      // The shell owns the aurora background, so it persists (and never
      // restarts) across page navigation.
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => _fadePage(state, const LandingPage()),
        ),
        GoRoute(
          path: '/resume',
          pageBuilder: (context, state) => _fadePage(state, const ResumePage()),
        ),
        GoRoute(
          path: '/software',
          pageBuilder: (context, state) =>
              _fadePage(state, const ProjectsPage(type: ProjectType.software)),
        ),
        GoRoute(
          path: '/hardware',
          pageBuilder: (context, state) =>
              _fadePage(state, const ProjectsPage(type: ProjectType.hardware)),
        ),
        // Catch-all inside the shell so the 404 page keeps the aurora backdrop.
        GoRoute(
          path: '/:notFound(.*)',
          pageBuilder: (context, state) =>
              _fadePage(state, const NotFoundPage()),
        ),
      ],
    ),
  ],
);
