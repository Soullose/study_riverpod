import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_riverpod/common/provider/shared_preferences_provider.dart';
import 'package:study_riverpod/common/routers/app_router.dart';
import 'package:study_riverpod/common/utils/state_logger/state_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      observers: const [StateLogger()],
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
      // home: Scaffold(
      //   body: Container(
      //     child: Column(
      //       children: [
      //         ElevatedButton(
      //           onPressed: () {
      //
      //           },
      //           child: const Text('to example'),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
//
// enum City {
//   nanjing,
//   beijing,
//   shanghai,
// }
//
// typedef WeatherEmoji = String;
//
// Future<WeatherEmoji> getWeather(City city) {
//   return Future.delayed(
//     const Duration(seconds: 1),
//     () => {City.beijing: '雪花', City.nanjing: '打伞', City.shanghai: '太阳'}[city]!,
//   );
// }
//
// final currentCityProvider = StateProvider<City?>((ref) => null);
//
// const unknowWeatherEmoji = '阿偶';
//
// final weatherProvider = FutureProvider(
//   (ref) {
//     final city = ref.watch(currentCityProvider);
//     if (city != null) {
//       return getWeather(city);
//     } else {
//       return unknowWeatherEmoji;
//     }
//   },
// );
//
// class HomePage extends ConsumerWidget {
//   const HomePage({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentWeather = ref.watch(
//       weatherProvider,
//     );
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Weather'),
//       ),
//       body: Column(
//         children: [
//           currentWeather.when(
//             data: (data) => Text(
//               data.toString(),
//               style: const TextStyle(fontSize: 40),
//             ),
//             error: (_, __) => const Text('error'),
//             loading: () => const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: CircularProgressIndicator(),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: City.values.length,
//               itemBuilder: (context, index) {
//                 final city = City.values[index];
//                 final isSelected = city == ref.watch(currentCityProvider);
//                 return ListTile(
//                   title: Text(city.toString()),
//                   trailing: isSelected ? const Icon(Icons.check) : null,
//                   onTap: () {
//                     ref.read(currentCityProvider.notifier).state = city;
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
