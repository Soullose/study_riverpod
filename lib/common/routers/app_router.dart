import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_riverpod/common/routers/router_notifier.dart';
import 'package:study_riverpod/pages/example.dart';
import 'package:study_riverpod/pages/example_6.dart';
import 'package:study_riverpod/pages/example_add_data.dart';
import 'package:study_riverpod/pages/example_mqtt.dart';
import 'package:study_riverpod/pages/example_tick.dart';
import 'package:study_riverpod/pages/home.dart';
import 'package:study_riverpod/pages/login_page.dart';
import 'package:study_riverpod/pages/setting.dart';
import 'package:study_riverpod/pages/splash_page.dart';

final _key = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
      navigatorKey: _key,
      refreshListenable: notifier,
      debugLogDiagnostics: true,
      initialLocation: "/splash_page",
      routes: routes,
      redirect: notifier.redirect);
});

List<GoRoute> get routes => [
      GoRoute(
          path: "/",
          builder: (_, __) => const HomePage(),
          redirect: (context, state) {
            if (state.location == "/") return null;
            return null;
          }),
      GoRoute(
        path: "/example",
        // builder: (_, __) => const ExamplePage(),
        pageBuilder: (_, __) => CustomTransitionPage(
          key: __.pageKey,
          child: const ExamplePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: "/example_tick_page",
        builder: (_, __) => const ExampleTickPage(),
      ),
      GoRoute(
        path: "/example_add_data",
        builder: (_, __) => const ExampleAddData(),
      ),
      GoRoute(
        path: "/example_6",
        builder: (_, __) => const Example6(),
      ),
      GoRoute(
        path: "/setting",
        builder: (_, __) => const SettingPage(),
      ),
      GoRoute(
        path: "/mqtt_page",
        builder: (_, __) => const ExampleMqttPage(),
      ),
      GoRoute(
        path: "/splash_page",
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: "/login_page",
        builder: (_, __) => const LoginPage(),
      ),
    ];

final router = GoRouter(
  routes: [
    GoRoute(
        path: "/",
        builder: (_, __) => const HomePage(),
        redirect: (context, state) {
          if (state.location == "/") return null;
          return null;
        }),
    GoRoute(
      path: "/example",
      // builder: (_, __) => const ExamplePage(),
      pageBuilder: (_, __) => CustomTransitionPage(
        key: __.pageKey,
        child: const ExamplePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Change the opacity of the screen using a Curve based on the the animation's
          // value
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: "/example_tick_page",
      builder: (_, __) => const ExampleTickPage(),
    ),
    GoRoute(
      path: "/example_add_data",
      builder: (_, __) => const ExampleAddData(),
    ),
    GoRoute(
      path: "/example_6",
      builder: (_, __) => const Example6(),
    ),
    GoRoute(
      path: "/setting",
      builder: (_, __) => const SettingPage(),
    ),
    GoRoute(
      path: "/mqtt_page",
      builder: (_, __) => const ExampleMqttPage(),
    ),
    GoRoute(
      path: "/splash_page",
      builder: (_, __) => const SplashPage(),
    ),
    GoRoute(
      path: "/login_page",
      builder: (_, __) => const LoginPage(),
    ),
  ],
);

// class SplashRoute extends GoRouteData {
//   const SplashRoute();
//
//   static const path = './splash';
// }
