import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/settings/page/settings_view_model.dart';
import 'package:key_viewer_v2/settings/page/widget/key_tile_settings_dialog.dart';
import 'package:win32/win32.dart';
import 'package:window_manager_plus/window_manager_plus.dart';

import 'widget/grid_snap_editor.dart';

class KeyViewerSettingsPage extends ConsumerStatefulWidget {
  const KeyViewerSettingsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<KeyViewerSettingsPage> createState() => _KeyViewerSettingsPageState();
}

class _KeyViewerSettingsPageState extends ConsumerState<KeyViewerSettingsPage> with WindowListener {
  late final SettingsViewModel viewModel;

  @override
  void initState() {
    viewModel = ref.read(settingsViewModelProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      viewModel.showOverlay();
    });
    super.initState();
  }

  double _cell = 4;
  double _gap  = 1;

  Widget _numSlider({
    required String label,
    required double min,
    required double max,
    required double value,
    int divisions = 100,
    String suffix = 'px',
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Text('${value.toStringAsFixed(0)}$suffix'),
        ]),
        Slider(
          min: min, max: max, divisions: divisions,
          value: value,
          label: value.toStringAsFixed(0),
          onChanged: (v) => setState(() => onChanged(v)),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    final spec = SnapGridSpec(cell: _cell, gap: _gap);
    final state = ref.watch(settingsViewModelProvider);
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  GridSnapEditor(
                    grid: spec,
                    targetKeyList: state.keyTileData,
                    onChanged: (updated) {
                      viewModel.updateKeyTileData(updated);
                    },
                    onPixelSizeChanged: (size){
                      viewModel.setEditorSize(size);
                      viewModel.resizeOverlay();
                    }, pressedKeySet: {},
                  ),

                  IconButton(
                    onPressed: () async {
                      final data = await showDialog<KeyTileDataModel>(
                          context: context,
                          builder: (_) => KeyTileSettingDialog(cellPx: _cell, gapPx: _gap,),
                        barrierDismissible: false
                      );
                      print(data);
                      if(data != null){
                        viewModel.addKeyTile(data);
                      }
                    },
                    icon: Icon(Icons.add),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}