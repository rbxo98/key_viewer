import 'package:flutter/material.dart';
import 'package:key_viewer_v2/core/model/config/multi_window_option_model.dart';

class SubWindowPage extends StatelessWidget {
  final MultiWindowOptionModel multiWindowOptionModel;
  final int windowId;
  const SubWindowPage({Key? key, required this.multiWindowOptionModel, required this.windowId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('SubWindowPage')),
    );
  }
}