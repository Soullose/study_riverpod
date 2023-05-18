import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:study_riverpod/common/provider/basic_storage_provider.dart';

final serveAddress =
    StateProvider<String?>((ref) => ref.watch(ipAddressProvider));

class MqttClientState extends StateNotifier<MqttClientConnectionStatus> {
  MqttClientState() : super(MqttClientConnectionStatus.disconnected);

  final client = MqttClient('ipAddressProvider', '1883');

  Future<void> connect() async {
    state = MqttClientConnectionStatus.connecting;
    client.logging(on: false);
    client.keepAlivePeriod = 20;
    client.setProtocolV311();
    client.connectTimeoutPeriod = 2000;
    client.autoReconnect = true;
    client.resubscribeOnAutoReconnect = false;

    /// Add an auto reconnect callback.
    /// This is the 'pre' auto re connect callback, called before the sequence starts.
    client.onAutoReconnect = onAutoReconnect;

    /// Add an auto reconnect callback.
    /// This is the 'post' auto re connect callback, called after the sequence
    /// has completed. Note that re subscriptions may be occurring when this callback
    /// is invoked. See [resubscribeOnAutoReconnect] above.
    client.onAutoReconnected = onAutoReconnected;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    try {
      await client.connect();
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
      disconnect();
    }
  }

  void disconnect() {
    client.disconnect();
    state = MqttClientConnectionStatus.disconnected;
  }

  void subscribe(String topic) {
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  /// The pre auto re connect callback
  void onAutoReconnect() {
    if (kDebugMode) {
      print(
          'EXAMPLE::onAutoReconnect client callback - Client auto reconnection sequence will start');
    }
  }

  /// The post auto re connect callback
  void onAutoReconnected() {
    if (kDebugMode) {
      print(
          'EXAMPLE::onAutoReconnected client callback - Client auto reconnection sequence has completed');
    }
  }

  void onConnected() {
    state = MqttClientConnectionStatus.connected;
  }

  void onDisconnected() {
    state = MqttClientConnectionStatus.disconnected;
  }

  void onSubscribed(String topic) {
    if (kDebugMode) {
      print('Subscribed to topic $topic');
    }
  }

  void pong() {
    if (kDebugMode) {
      print('Ping response');
    }
  }
}

enum MqttClientConnectionStatus { connecting, connected, disconnected }
