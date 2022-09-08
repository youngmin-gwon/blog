import 'package:blog/src/core/presentation/page/home_screen.dart';
import 'package:blog/src/core/presentation/page/error_screen.dart';
import 'package:blog/src/setting/presentation/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_route_observer.dart';

final appRouterProvider = Provider<AppRouter>(
  (ref) => AppRouter(
    observer: ref.watch(routeObserverProvider),
  ),
);

class AppRouter extends GoRouter {
  final RouteObserver<PageRoute> observer;

  AppRouter({
    required this.observer,
  }) : super(
          initialLocation: '/',
          urlPathStrategy: UrlPathStrategy.path,
          observers: [observer],
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) =>
                  const MaterialPage(child: HomeScreen()),
            ),
            GoRoute(
              path: '/setting',
              pageBuilder: (context, state) => const MaterialPage(
                child: SettingScreen(),
              ),
            ),
          ],
          errorPageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const ErrorScreen(),
          ),
        );
}
