import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListExample1Page extends ConsumerStatefulWidget {
  const ListExample1Page({
    super.key,
  });

  @override
  ConsumerState createState() => _ListExample1PageState();
}

class _ListExample1PageState extends ConsumerState<ListExample1Page> {
  ///控制列表滚动和监听
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        child: CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Container(
              color: Colors.blue[(index % 5) * 100],
              height: 20,
              alignment: Alignment.center,
              child: Text('$index'),
            ),
            childCount: 88,
          ),
        )
      ],
    ));
  }
}
