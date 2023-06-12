import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_riverpod/common/provider/shared_preferences_provider.dart';
import 'package:study_riverpod/common/routers/app_router.dart';
import 'package:study_riverpod/common/utils/state_logger/state_logger.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

void main() async {
  // FlutterError.demangleStackTrace = true;
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      // observers: const [StateLogger()],
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.light(useMaterial3: true),
      themeMode: ThemeMode.light,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      routerConfig: router,
    );
  }
}
