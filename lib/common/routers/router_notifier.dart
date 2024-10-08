import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:study_riverpod/common/state/auth.dart';

class RouterNotifier extends AutoDisposeAsyncNotifier<void>
    implements Listenable {
  VoidCallback? routerListener;
  bool isAuth = false; // Useful for our global redirect functio

  @override
  FutureOr<void> build() async {
    isAuth = await ref.watch(authNotifierProvider.selectAsync(
        (data) => data.map(signedIn: (_) => true, signedOut: (_) => false)));

    log('isAuth:--$isAuth');
    ref.listenSelf((previous, next) {
      if (state.isLoading) return;

      routerListener?.call();
    });
    // throw UnimplementedError();
  }

  /// Redirects the user when our authentication changes
  Future<String?> redirect(BuildContext context, GoRouterState state) async {
    if (this.state.isLoading || this.state.hasError) return null;

    final isSplash = state.uri.toString() == "/splash_page";

    if (isSplash) {
      await Future.delayed(const Duration(seconds: 3));
      return isAuth ? "/home" : "/login_page";
    }

    final isLoggingIn = state.uri.toString() == "/login_page";
    if (isLoggingIn) return isAuth ? "/home" : null;

    return isAuth ? null : "/login_page";
  }

  @override
  void addListener(VoidCallback listener) {
    routerListener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    routerListener = null;
  }
}

final routerNotifierProvider =
    AutoDisposeAsyncNotifierProvider<RouterNotifier, void>(() {
  return RouterNotifier();
});
