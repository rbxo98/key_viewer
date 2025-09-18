
import 'dart:convert';

import 'package:key_viewer_v2/core/model/config/config_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefProvider {
  PrefProvider._();
  static final PrefProvider _instance = PrefProvider._();
  static late final _pref;
  static PrefProvider get instance => _instance;
  static bool _isInit = false;

  static const String _CONFIG_KEY = "KR_GAPUR_CONFIG_KEY";

  static Future<void> init() async {
    if (_isInit) return;
    _pref = await SharedPreferences.getInstance();
    _isInit = true;
  }

  static Future<GlobalConfigModel> getGlobalConfig() async {
    return GlobalConfigModel.fromJson(jsonDecode(_pref.getString(_CONFIG_KEY) ?? "{}"));
  }

  static Future<void> setGlobalConfig(GlobalConfigModel globalConfig) async {
    await _pref.setString(_CONFIG_KEY, jsonEncode(globalConfig.toJson()));
  }
}