import 'package:flutter/material.dart';
import 'package:key_viewer_v2/settings/page/setttings_page.dart';

class KeyViewerSettingApp extends StatelessWidget {
  const KeyViewerSettingApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.transparent,
      title: 'Settings',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: KeyViewerSettingsPage(),
    );
  }
}
