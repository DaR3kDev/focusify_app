import 'package:flutter/material.dart';
import 'package:focusify_app/features/home/presentation/screens/home_screen.dart';
import 'package:focusify_app/features/settgins/presentation/setting_screen.dart';
import 'package:focusify_app/shared/widgets/layout/app_scaffold.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppScaffold(pages: const [HomeScreen(), SettingScreen()]);
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => const SizedBox()),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SizedBox(),
        ),
      ],
    ),
  ],
);
