import 'package:flutter/material.dart';
import 'package:key_viewer_v2/core/model/multi_window_option/multi_window_option_model.dart';
import 'package:key_viewer_v2/settings/page/settings_page.dart';
import 'package:key_viewer_v2/sub_window/page/sub_window_page.dart';

class SubWindowApp extends StatelessWidget {
  final MultiWindowOptionModel multiWindowOptionModel;
  final int windowId;
  const SubWindowApp({super.key, required this.multiWindowOptionModel, required this.windowId});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.transparent,
      title: 'SubWindow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SubWindowPage(multiWindowOptionModel: multiWindowOptionModel, windowId: windowId,),
    );
  }
}
