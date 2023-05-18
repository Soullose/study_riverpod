import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum City {
  nanjing,
  beijing,
  shanghai,
}

typedef WeatherEmoji = String;

Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
    const Duration(seconds: 1),
    () => {City.beijing: '雪花', City.nanjing: '打伞', City.shanghai: '太阳'}[city]!,
  );
}

final currentCityProvider = StateProvider<City?>((ref) => null);

const unknowWeatherEmoji = '阿偶';

final weatherProvider = FutureProvider(
  (ref) {
    final city = ref.watch(currentCityProvider);
    if (city != null) {
      return getWeather(city);
    } else {
      return unknowWeatherEmoji;
    }
  },
);

class ExamplePage extends ConsumerWidget {
  const ExamplePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(
      weatherProvider,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Column(
        children: [
          currentWeather.when(
            data: (data) => Text(
              data.toString(),
              style: const TextStyle(fontSize: 40),
            ),
            error: (_, __) => const Text('error'),
            loading: () => const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: City.values.length,
              itemBuilder: (context, index) {
                final city = City.values[index];
                final isSelected = city == ref.watch(currentCityProvider);
                return ListTile(
                  title: Text(city.toString()),
                  trailing: isSelected ? const Icon(Icons.check) : null,
                  onTap: () {
                    ref.read(currentCityProvider.notifier).state = city;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
