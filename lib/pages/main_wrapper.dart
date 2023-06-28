import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_riverpod/common/utils/log/log_utils.dart';
import 'package:study_riverpod/common/widget/wsf_navigation_bar.dart';

import 'main_wrapper_state.dart';

class MainWrapperPage extends ConsumerWidget {
  const MainWrapperPage({
    required this.navigationShell,
    Key? key,
  }) : super(key: key);

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return Scaffold(
    //   bottomNavigationBar: NavigationBar(
    //     destinations: const [
    //       NavigationDestination(icon: Icon(Icons.login_outlined), label: "入库"),
    //       NavigationDestination(icon: Icon(Icons.logout_outlined), label: "出库"),
    //     ],
    //     selectedIndex: ref.watch(mainWrapperProvider),
    //     onDestinationSelected: (int index) {
    //       ref.read(mainWrapperProvider.notifier).select(index);
    //       return navigationShell.goBranch(index,
    //           initialLocation: navigationShell.currentIndex == index);
    //     },
    //   ),
    //   body: navigationShell,
    // );

    return Scaffold(
      bottomNavigationBar: WSFNavigationBarWidget(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.login_outlined), label: "入库"),
          NavigationDestination(icon: Icon(Icons.telegram_sharp), label: "测试"),
          NavigationDestination(icon: Icon(Icons.logout_outlined), label: "出库"),
        ],
        selectedIndex: ref.watch(mainWrapperProvider),
        onDestinationSelected: (int index) {
          ref.read(mainWrapperProvider.notifier).select(index);
          return navigationShell.goBranch(index,
              initialLocation: navigationShell.currentIndex == index);
        },
        onDoubleTap: (index) => LogUtils.d('第几$index页'),
      ),
      body: navigationShell,
    );
  }
}
