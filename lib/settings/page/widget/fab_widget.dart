import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/settings/page/settings_view_model.dart';
import 'package:key_viewer_v2/settings/page/widget/key_tile_settings_dialog.dart';

class ExpandableFabWidget extends StatelessWidget {
  final double cell;
  final double gap;
  final SettingsViewModel viewModel;

  const ExpandableFabWidget({
    required this.cell,
    required this.gap,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    // Consumer를 여기서만 사용 (FAB 상태와 분리)
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(settingsViewModelProvider);
        return ExpandableFab(
          onOpen: () => print('FAB opening'),
          afterOpen: () => print('FAB opened'),
          onClose: () => print('FAB closing'),
          afterClose: () => print('FAB closed'),
          openButtonBuilder: RotateFloatingActionButtonBuilder(
              child: Icon(Icons.settings),
              shape: CircleBorder()
          ),
          closeButtonBuilder: RotateFloatingActionButtonBuilder(
            child: Icon(Icons.close),
          ),
          type: ExpandableFabType.up,
          childrenAnimation: ExpandableFabAnimation.none,
          distance: 70,
          children: [
            Row(
              children: [
                Text('키 추가'),
                SizedBox(width: 20),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () async {
                    final data = await showDialog<KeyTileDataModel>(
                        context: context,
                        builder: (_) => KeyTileSettingDialog(cellPx: cell, gapPx: gap,),
                        barrierDismissible: false
                    );
                    if(data != null){
                      viewModel.addKeyTile(data);
                    }
                  },
                  child: Icon(Icons.add),
                ),
              ],
            ),
            Row(
              children: [
                Text('윈도우 사이즈 잠금'),
                SizedBox(width: 20),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () async {
                    viewModel.toggleWindowSizeLock();
                  },
                  child: state.windowSizeLock?Icon(Icons.lock_open):Icon(Icons.lock),
                ),
              ],
            ),

            Row(
              children: [
                Text('전역 환경 설정'),
                SizedBox(width: 20),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () async {
                  },
                  child: Icon(Icons.settings_applications),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}