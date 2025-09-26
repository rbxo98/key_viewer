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
///
class KeyInputMonitor {
  /// 폴링 주기 (기본 16ms)
  final Duration tick;

  Timer? _timer;

  /// 현재 눌려있는 VK 코드들의 집합.
  /// addListener로 구독해서 UI/로직에서 사용하세요.
  /// 주의: 외부에서 `pressedKeys.value` Set을 직접 수정하지 마세요.
  /// 항상 읽기만 하고, 변경은 모니터 내부에서 새 Set으로 교체합니다.
  final ValueNotifier<Set<int>> pressedKeys = ValueNotifier<Set<int>>(<int>{});

  /// 마우스 VK: 전부 제외(키보드만 반환)
  static const Set<int> _mouseVKs = {
    VIRTUAL_KEY.VK_LBUTTON,  // 0x01
    VIRTUAL_KEY.VK_RBUTTON,  // 0x02
    VIRTUAL_KEY.VK_MBUTTON,  // 0x04
    VIRTUAL_KEY.VK_XBUTTON1, // 0x05
    VIRTUAL_KEY.VK_XBUTTON2, // 0x06
  };

  /// 스캔 범위 (0x01 ~ 0xFE)
  static const int _vkMin = 0x01;
  static const int _vkMax = 0xFE; // 0xFF는 정의되지 않음

  KeyInputMonitor({this.tick = const Duration(milliseconds: 16)});

  bool get isRunning => _timer != null;

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
  /// 1) 전체 VK 범위를 순회
  /// 2) 마우스 VK는 제외
  Set<int> snapshotPressed() {
    final nowPressed = <int>{};
    for (int vk = _vkMin; vk <= _vkMax; vk++) {
      if (_mouseVKs.contains(vk)) continue; // 마우스 제외
      final state = GetAsyncKeyState(vk);
      if ((state & 0x8000) != 0) {
        nowPressed.add(vk);
      }
    }
    return nowPressed;
  }

  void _pollOnce() {
    final nowPressed = <int>{};
    for (int vk = _vkMin; vk <= _vkMax; vk++) {
      if (_mouseVKs.contains(vk)) continue; // 마우스 제외
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
