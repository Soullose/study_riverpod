import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// idea CarGuo
/// https://github.com/CarGuo/gsy_github_app_flutter/blob/master/lib/widget/gsy_tabbar_widget.dart

class WSFNavigationBarWidget extends ConsumerStatefulWidget {
  final List<Widget> destinations;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final ValueChanged<int>? onTap;
  final ValueChanged<int>? onDoubleTap;

  const WSFNavigationBarWidget({
    Key? super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.onTap,
    this.onDoubleTap,
  });

  @override
  ConsumerState createState() => _WSFNavigationBarWidgetState();
}

class _WSFNavigationBarWidgetState
    extends ConsumerState<WSFNavigationBarWidget> {
  _onDestinationSelected(int index) {
    widget.onDestinationSelected!.call(index);
  }

  _onTap(int index) {
    widget.onTap!.call(index);
  }

  _onDoubleTap(int index) {
    widget.onDoubleTap!.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(widget.selectedIndex),
      onDoubleTap: () => _onDoubleTap(widget.selectedIndex),
      child: NavigationBar(
        destinations: widget.destinations,
        selectedIndex: widget.selectedIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}
