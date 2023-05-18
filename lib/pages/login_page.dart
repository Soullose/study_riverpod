import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/state/auth.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Login Page"),
            ElevatedButton(
              onPressed: () async {
                ref.watch(authNotifierProvider.notifier).login(
                      "myEmail",
                      "myPassword",
                    );
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
