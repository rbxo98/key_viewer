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
  final KeyInputMonitor keyInputMonitor = KeyInputMonitor();
  @override
  void initState() {
    super.initState();
    WindowManagerPlus.current.addListener(this);
    viewModel = ref.read(keyViewerOverlayViewModelProvider.notifier);
    viewModel.setupWindowByGrid();
    keyInputMonitor.pressedKeys.addListener(() {
      viewModel.updatePressedKeySet(keyInputMonitor.pressedKeys.value);
    });
    keyInputMonitor.start();
  }

  @override
  void dispose() {
    WindowManagerPlus.current.removeListener(this);
    super.dispose();
  }

  @override
  Future<dynamic> onEventFromWindow(String eventName, int fromWindowId, dynamic arguments) async {
    print(eventName);
    switch (eventName) {
      case "updateKeyTile": {
        viewModel.updateOverlayKeyTile(arguments);
        return true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(keyViewerOverlayViewModelProvider);
    print(state);
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
        backgroundColor: Colors.transparent,
        body: GridSnapEditor(
            targetKeyList: state.keyTileData,
            pressedKeySet: state.pressedKeySet,
          showBackground: false,
          isEditor: false,
        )
      ),
    );
  }
}