import 'package:flutter/material.dart';
import 'package:key_viewer_v2/core/model/multi_window_option/multi_window_option_model.dart';
import 'package:key_viewer_v2/overlay/page/key_viewer_overlay_page.dart';



class KeyViewerOverlayApp extends StatelessWidget {
  final int windowId;
  final MultiWindowOptionModel multiWindowOptionModel;
  const KeyViewerOverlayApp({super.key, required this.windowId, required this.multiWindowOptionModel});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.transparent,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: KeyViewerOverlayPage(windowId: windowId, multiWindowOptionModel: multiWindowOptionModel,),
    );
  }
}
