import 'dart:collection';

import 'package:key_viewer_v2/core/model/preset/preset_model.dart';

class AppUtil{
  AppUtil._();
  static final AppUtil _instance = AppUtil._();
  static AppUtil get instance => _instance;

  static LinkedHashSet<PresetModel> fromJson(List<Map<String, dynamic>> json) {
    return LinkedHashSet<PresetModel>(
      equals: (a, b) => a.presetName == b.presetName,
      hashCode: (u) => u.presetName.hashCode,
    )..addAll(json.map(PresetModel.fromJson));
  }

  static List<Map<String, dynamic>> toJson(LinkedHashSet<PresetModel> set) {
    return set.map((e) => e.toJson()).toList();
  }
}