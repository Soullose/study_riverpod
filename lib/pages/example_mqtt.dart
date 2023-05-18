import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_riverpod/common/provider/mqtt_provider.dart';
import 'package:study_riverpod/common/utils/nanoid/async/nanoid.dart';
import 'package:study_riverpod/common/utils/nanoid/nanoid.dart';

class ExampleMqttPage extends ConsumerWidget {
  const ExampleMqttPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mqttProviderNotifier = ref.watch(mqttProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mqtt 测试案例'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  if (kDebugMode) {
                    print('object');
                  }
                  await mqttProviderNotifier.connect();
                },
                child: const Text('连接Mqtt')),
            ElevatedButton(
                onPressed: () async {
                  if (kDebugMode) {
                    print('object');
                  }
                  mqttProviderNotifier.disconnect();
                },
                child: const Text('断开Mqtt')),
            ElevatedButton(
                onPressed: () async {
                  if (kDebugMode) {
                    print(nanoid());
                  }
                  if (kDebugMode) {
                    print(await nanoidAsync());
                  }
                },
                child: const Text('测试nanoid')),
          ],
        ),
      ),
    );
  }
}
