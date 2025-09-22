// key_input_monitor.dart
import 'dart:async';
import 'package:flutter/foundation.dart'; // ValueNotifier
import 'package:win32/win32.dart';

/// 키보드 입력만을 주기적으로 스캔해서
/// "현재 눌려있는 키들의 집합"을 ValueNotifier로 내보내는 모니터.
///
/// 사용:
/// final monitor = KeyInputMonitor();
/// monitor.pressedKeys.addListener(() { print(monitor.pressedKeys.value); });
/// monitor.start(); ... monitor.dispose();
class KeyInputMonitor {
  /// 폴링 주기 (기본 16ms)
  final Duration tick;

  Timer? _timer;

  /// 현재 눌려있는 VK 코드들의 집합.
  /// addListener로 구독해서 UI/로직에서 사용하세요.
  /// 주의: 외부에서 `pressedKeys.value` Set을 직접 수정하지 마세요.
  /// 항상 읽기만 하고, 변경은 모니터 내부에서 새 Set으로 교체합니다.
  final ValueNotifier<Set<int>> pressedKeys = ValueNotifier<Set<int>>(<int>{});

  /// 키보드 입력만 포함하는 VK 코드들
  static final List<int> _keyboardVk = _generateKeyboardVkList();

  KeyInputMonitor({this.tick = const Duration(milliseconds: 16)});

  bool get isRunning => _timer != null;

  /// 키보드 Virtual Key 코드만 생성
  static List<int> _generateKeyboardVkList() {
    final List<int> keyboardKeys = [];

    // 영숫자 키 (0-9, A-Z)
    for (int i = 0x30; i <= 0x39; i++) keyboardKeys.add(i); // 0-9
    for (int i = 0x41; i <= 0x5A; i++) keyboardKeys.add(i); // A-Z

    // 기능키 (F1-F24)
    for (int i = 0x70; i <= 0x87; i++) keyboardKeys.add(i); // F1-F24

    // 숫자 패드
    for (int i = 0x60; i <= 0x6F; i++) keyboardKeys.add(i); // Numpad 0-9, *, +, separator, -, ., /

    // 기본 제어키들
    keyboardKeys.addAll([
      VIRTUAL_KEY.VK_BACK,        // 8 - Backspace
      VIRTUAL_KEY.VK_TAB,         // 9 - Tab
      VIRTUAL_KEY.VK_RETURN,      // 13 - Enter
      VIRTUAL_KEY.VK_SHIFT,       // 16 - Shift
      VIRTUAL_KEY.VK_CONTROL,     // 17 - Ctrl
      VIRTUAL_KEY.VK_MENU,        // 18 - Alt
      VIRTUAL_KEY.VK_PAUSE,       // 19 - Pause
      VIRTUAL_KEY.VK_CAPITAL,     // 20 - Caps Lock
      VIRTUAL_KEY.VK_ESCAPE,      // 27 - Esc
      VIRTUAL_KEY.VK_SPACE,       // 32 - Space
      VIRTUAL_KEY.VK_PRIOR,       // 33 - Page Up
      VIRTUAL_KEY.VK_NEXT,        // 34 - Page Down
      VIRTUAL_KEY.VK_END,         // 35 - End
      VIRTUAL_KEY.VK_HOME,        // 36 - Home
      VIRTUAL_KEY.VK_LEFT,        // 37 - Left Arrow
      VIRTUAL_KEY.VK_UP,          // 38 - Up Arrow
      VIRTUAL_KEY.VK_RIGHT,       // 39 - Right Arrow
      VIRTUAL_KEY.VK_DOWN,        // 40 - Down Arrow
      VIRTUAL_KEY.VK_INSERT,      // 45 - Insert
      VIRTUAL_KEY.VK_DELETE,      // 46 - Delete
    ]);

    // 좌우 구분되는 제어키들
    keyboardKeys.addAll([
      VIRTUAL_KEY.VK_LSHIFT,      // 160 - Left Shift
      VIRTUAL_KEY.VK_RSHIFT,      // 161 - Right Shift
      VIRTUAL_KEY.VK_LCONTROL,    // 162 - Left Control
      VIRTUAL_KEY.VK_RCONTROL,    // 163 - Right Control
      VIRTUAL_KEY.VK_LMENU,       // 164 - Left Alt
      VIRTUAL_KEY.VK_RMENU,       // 165 - Right Alt
    ]);

    // 특수 기호 키들 (키보드 레이아웃에 따라 다를 수 있음)
    keyboardKeys.addAll([
      186, // VK_OEM_1 (;:)
      187, // VK_OEM_PLUS (=+)
      188, // VK_OEM_COMMA (,<)
      189, // VK_OEM_MINUS (-_)
      190, // VK_OEM_PERIOD (.>)
      191, // VK_OEM_2 (/?)
      192, // VK_OEM_3 (`~)
      219, // VK_OEM_4 ([{)
      220, // VK_OEM_5 (\|)
      221, // VK_OEM_6 (]})
      222, // VK_OEM_7 ('")
    ]);

    // Windows 키들
    keyboardKeys.addAll([
      VIRTUAL_KEY.VK_LWIN,        // 91 - Left Windows
      VIRTUAL_KEY.VK_RWIN,        // 92 - Right Windows
      VIRTUAL_KEY.VK_APPS,        // 93 - Applications (Menu)
    ]);

    // 기타 키보드 키들
    keyboardKeys.addAll([
      VIRTUAL_KEY.VK_NUMLOCK,     // 144 - Num Lock
      VIRTUAL_KEY.VK_SCROLL,      // 145 - Scroll Lock
      VIRTUAL_KEY.VK_SNAPSHOT,    // 44 - Print Screen
    ]);

    return keyboardKeys..sort();
  }

  /// 시작
  void start() {
    if (_timer != null) return;
    _timer = Timer.periodic(tick, (_) => _pollOnce());
  }

  /// 정지
  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  /// 해제
  void dispose() {
    stop();
    pressedKeys.dispose();
  }

  /// 즉시 스냅샷(한 번만 스캔해서 현재 눌린 키 집합 반환)
  Set<int> snapshotPressed() {
    final nowPressed = <int>{};
    for (final vk in _keyboardVk) {
      final state = GetAsyncKeyState(vk);
      if ((state & 0x8000) != 0) {
        nowPressed.add(vk);
      }
    }
    return nowPressed;
  }

  void _pollOnce() {
    final nowPressed = <int>{};
    for (final vk in _keyboardVk) {
      final state = GetAsyncKeyState(vk);
      // 최상위 비트(0x8000): 지금 눌려있음
      if ((state & 0x8000) != 0) {
        nowPressed.add(vk);
      }
    }

    // 이전 스냅샷과 다를 때만 갱신 (리빌드 최소화)
    final prev = pressedKeys.value;
    final changed = prev.length != nowPressed.length || !prev.containsAll(nowPressed);
    if (changed) {
      // 새 Set으로 교체해야 ValueNotifier가 변경으로 인식
      pressedKeys.value = nowPressed;
    }
  }
}