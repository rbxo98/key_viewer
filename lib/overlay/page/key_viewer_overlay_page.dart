import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:key_viewer_v2/core/lib/key_input_monitor.dart';
import 'package:key_viewer_v2/core/model/multi_window_option/multi_window_option_model.dart';
import 'package:key_viewer_v2/overlay/page/key_viewer_overlay_view_model.dart';
import 'package:key_viewer_v2/settings/page/widget/grid_snap_editor.dart';
import 'package:window_manager_plus/window_manager_plus.dart';

class KeyViewerOverlayPage extends ConsumerStatefulWidget {
  final int windowId;
  final MultiWindowOptionModel multiWindowOptionModel;

  const KeyViewerOverlayPage({Key? key, required this.windowId, required this.multiWindowOptionModel}) : super(key: key);

  @override
  ConsumerState<KeyViewerOverlayPage> createState() => _KeyViewerOverlayPageState();
}

class _KeyViewerOverlayPageState extends ConsumerState<KeyViewerOverlayPage> with WindowListener {
  late final KeyViewerOverlayViewModel viewModel;
  bool _windowReady = false;
  @override
  void initState() {
    super.initState();
    viewModel = ref.read(keyViewerOverlayViewModelProvider.notifier);
    WindowManagerPlus.current.addListener(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await WindowManagerPlus.current.waitUntilReadyToShow().then((value) {_windowReady = true;});
    });
  }

  @override
  void dispose() {
    WindowManagerPlus.current.removeListener(this);
    super.dispose();
  }

  @override
  Future<dynamic> onEventFromWindow(String eventName, int fromWindowId, dynamic arguments) async {
    while(!_windowReady) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    switch (eventName) {
      case "updateKeyTile": {
        viewModel.updateOverlayKeyTile(arguments);
        return true;
      }
    }
  }

  @override
  void onWindowMove([int? windowId]) async {
    final pos = await WindowManagerPlus.current.getPosition();
    WindowManagerPlus.current.invokeMethodToWindow(0, "updateOverlayPos", [pos.dx, pos.dy]);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(keyViewerOverlayViewModelProvider);
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) {
        // 좌클릭일 때만 창 드래그 시작
        const primary = kPrimaryMouseButton; // == 0x01
        if ((event.buttons & primary) != 0) {
          WindowManagerPlus.current.startDragging();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black.withAlpha(1),
        body: Column(
          children: [
            Expanded(
              child: GridSnapEditor(
                grid: SnapGridSpec(cell: widget.multiWindowOptionModel.cell??4, gap: widget.multiWindowOptionModel.gap??1),
                  targetKeyList: state.keyTileData,
                  pressedKeySet: state.pressedKeySet,
                showBackground: false,
                isEditor: false,
                showKeyCount: true,
              ),
            ),
          ],
        )
      ),
    );
  }
}