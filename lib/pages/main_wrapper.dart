import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainWrapperPage extends ConsumerWidget {
  const MainWrapperPage({
    required this.navigationShell,
    Key? key,
  }) : super(key: key);

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.login_outlined), label: "入库"),
          NavigationDestination(icon: Icon(Icons.logout_outlined), label: "出库"),
        ],
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (int index) => navigationShell.goBranch(index,
            initialLocation: navigationShell.currentIndex == index),
      ),
      body: navigationShell,
    );
  }
}
