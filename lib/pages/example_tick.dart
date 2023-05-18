import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const names = [
  'Alice',
  'Bob',
  'Charlie',
  'David',
  'Eve',
  'Fred',
  'Ginny',
  'Harriet',
  'Ileana',
  'Joseph',
  'Kincaid',
  'Larry',
];

final tickerProvider = StreamProvider(
  (ref) => Stream.periodic(
    const Duration(seconds: 1),
    (i) => i + 1,
  ),
);

final namesProvider = FutureProvider((ref) async {
  // final count = await ref.watch(tickerProvider.future).then((value) => names.getRange(0, value));

  final count = await ref.watch(tickerProvider.future);
  return names.getRange(0, count);
  // return count;
});

class ExampleTickPage extends ConsumerWidget {
  const ExampleTickPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream provider'),
      ),
      body: names.when(
        data: (names) => ListView.builder(
          itemCount: names.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(names.elementAt(index)),
            );
          },
        ),
        error: (error, stackTrace) => const Text('到达了最后!'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
