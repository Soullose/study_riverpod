import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_riverpod/common/provider/basic_storage_provider.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ipAddressController = TextEditingController();

    final ip = ref.watch(ipAddressProvider);

    String ipAddress = ip;

    ipAddressController.text = ipAddress;

    return Scaffold(
      appBar: AppBar(
        title: const Text('设置页面'),
      ),
      body: Column(
        children: [
          // TextField(
          //   controller: ipAddressController,
          //   decoration: const InputDecoration(labelText: '输入ip地址...'),
          //   // onChanged: (value) => ipAddress = value,
          // ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: Row(
              children: [
                const Text('服务地址'),
                const Spacer(),
                Consumer(builder: (context, ref, child) => Text(ip)),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('修改ip地址'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: ipAddressController,
                          decoration:
                              const InputDecoration(labelText: '输入ip地址...'),
                          onChanged: (value) => ipAddress = value,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('取消')),
                      TextButton(
                          onPressed: () {
                            ref.read(ipAddressProvider.notifier).state =
                                ipAddressController.text;
                            if (kDebugMode) {
                              print('服务地址:${serveAddress.name}');
                            }
                            if (kDebugMode) {
                              print('服务地址:${ref.watch(serveAddress)}');
                            }
                            Navigator.of(context).pop();
                          },
                          child: const Text('确定')),
                    ],
                  );
                },
              );
            },
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     AlertDialog(
          //       title: const Text('修改ip地址'),
          //       content: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           TextField(
          //             controller: ipAddressController,
          //             decoration: const InputDecoration(labelText: '输入ip地址...'),
          //             // onChanged: (value) => ipAddress = value,
          //           ),
          //         ],
          //       ),
          //     );
          //     ref.read(ipAddressProvider.notifier).state =
          //         ipAddressController.text;
          //   },
          //   child: const Text('保存'),
          // ),
        ],
      ),
    );
  }
}
