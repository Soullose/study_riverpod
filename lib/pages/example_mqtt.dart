import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:study_riverpod/common/provider/mqtt_provider.dart';
import 'package:study_riverpod/common/utils/log/log_utils.dart';
import 'package:study_riverpod/common/utils/nanoid/async/nanoid.dart';
import 'package:study_riverpod/common/utils/nanoid/nanoid.dart';

import '../common/provider/mqtt_connection_status_provider.dart';

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
                  final mqttConnectStateProvider = ref.watch(mqttClientConnectStatusProvider);

                  print('------:$mqttConnectStateProvider');

                  switch (mqttConnectStateProvider){
                    case MqttConnectionState.connected:
                      LogUtils.i('mqtt连接完成');
                      break;
                    case MqttConnectionState.disconnecting:
                      LogUtils.i('mqtt断开连接');
                      break;
                    case MqttConnectionState.disconnected:
                      LogUtils.i('mqtt没有连接主题');
                      break;
                    case MqttConnectionState.connecting:
                      LogUtils.i('mqtt连接ing');
                      break;
                    case MqttConnectionState.faulted:
                      LogUtils.i('mqtt连接失败');
                      break;
                  }
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
