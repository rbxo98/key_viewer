import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:key_viewer_v2/core/model/multi_window_option/multi_window_option_model.dart';
import 'package:key_viewer_v2/overlay/app/overlay_app.dart';
import 'package:key_viewer_v2/settings/app/setting_app.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as acrylic;
import 'package:window_manager_plus/window_manager_plus.dart';

import 'sub_window/app/sub_window_app.dart';

void main(List<String> args) async {
  if (args.isNotEmpty) {
    try{
      final multiWindowOption = MultiWindowOptionModel.fromJson(jsonDecode(args[1]));
      final windowId = int.tryParse(args[0]);
      switch(multiWindowOption.windowName){
        case "KeyViewerOverlay": {
          WidgetsFlutterBinding.ensureInitialized();
          await WindowManagerPlus.ensureInitialized(windowId!);
          await acrylic.Window.initialize();
          await acrylic.Window.setEffect(
            effect: acrylic.WindowEffect.transparent, // 퍼픽셀 투명
            color: Colors.transparent,
          );
          acrylic.Window.makeWindowFullyTransparent();
          runApp(ProviderScope(child: KeyViewerOverlayApp(windowId: windowId, multiWindowOptionModel: multiWindowOption,)));
          return;
        }
        default : {
          WidgetsFlutterBinding.ensureInitialized();
          await WindowManagerPlus.ensureInitialized(windowId!);
          runApp(ProviderScope(child: SubWindowApp(windowId: windowId, multiWindowOptionModel: multiWindowOption,)));
          return;
        }
      }
      return;
    }
    catch(e){
      print(e);
      return;
    }
  }

  WidgetsFlutterBinding.ensureInitialized();
  await WindowManagerPlus.ensureInitialized(0);
  // 기본 메인 윈도우 실행
  runApp(ProviderScope(child: const KeyViewerSettingApp()));
}
