import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/state/auth.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push("/example");
              },
              child: const Text('to example'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push("/example_tick_page");
              },
              child: const Text(
                'to example tick page',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.push("/example_add_data");
              },
              child: const Text(
                'to example add data',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.push("/example_6");
              },
              child: const Text(
                'to example_6',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.push("/setting");
              },
              child: const Text(
                'to setting page',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.push("/mqtt_page");
              },
              child: const Text(
                'to mqtt page',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.push("/huawei_auth_page");
              },
              child: const Text(
                'to huawei auth page',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref.watch(authNotifierProvider.notifier).logout();
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
