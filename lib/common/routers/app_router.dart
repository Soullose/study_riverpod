import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../modules/list_example/list_example_1.dart';
import '../../pages/admin_page.dart';
import '../../pages/example.dart';
import '../../pages/example_6.dart';
import '../../pages/example_add_data.dart';
import '../../pages/example_mqtt.dart';
import '../../pages/example_tick.dart';
import '../../pages/home.dart';
import '../../pages/login_page.dart';
import '../../pages/main_wrapper.dart';
import '../../pages/setting.dart';
import '../../pages/splash_page.dart';
import 'app_router_path.dart';
import 'router_notifier.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellKey');

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
      navigatorKey: _rootNavigatorKey,
      refreshListenable: notifier,
      debugLogDiagnostics: true,
      initialLocation: AppRouterPath.splashPage.path,
      routes: routes,
      redirect: notifier.redirect);
});

List<RouteBase> get routes => [
      GoRoute(
        path: AppRouterPath.example.path,
        pageBuilder: (_, __) => CustomTransitionPage(
          key: __.pageKey,
          child: const ExamplePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: AppRouterPath.exampleTickPage.path,
        builder: (_, __) => const ExampleTickPage(),
      ),
      GoRoute(
        path: AppRouterPath.exampleAddData.path,
        builder: (_, __) => const ExampleAddData(),
      ),
      GoRoute(
        path: AppRouterPath.example6.path,
        builder: (_, __) => const Example6(),
      ),
      GoRoute(
        path: AppRouterPath.setting.path,
        builder: (_, __) => const SettingPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRouterPath.mqttPage.path,
        builder: (_, __) => const ExampleMqttPage(),
      ),
      GoRoute(
        path: AppRouterPath.splashPage.path,
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: AppRouterPath.loginPage.path,
        builder: (_, __) => const LoginPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
                StatefulNavigationShell shell) =>
            MainWrapperPage(navigationShell: shell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: AppRouterPath.home.path,
                builder: (_, __) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRouterPath.listExample1.path,
                builder: (_, __) => const ListExample1Page(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRouterPath.admin.path,
                builder: (_, __) => const AdminPage(),
              ),
            ],
          ),
        ],
      ),
    ];
