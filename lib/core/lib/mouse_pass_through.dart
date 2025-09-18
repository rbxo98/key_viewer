// import 'dart:async';
// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:win32/win32.dart' as win;
// import 'package:ffi/ffi.dart';
// import 'package:window_manager_plus/window_manager_plus.dart';
//
// /// 창 내 '인터랙티브 영역'에 커서가 있으면 mouse 이벤트 허용,
// /// 아니면 클릭-스루로 만들어 아래 앱으로 통과시킵니다.
// class SelectiveMousePassthrough {
//   final _regions = <Rect>[];         // 창 좌표(논리 px) 기준
//   Timer? _timer;
//   bool _ignoring = true;             // 현재 ignore 상태
//   double devicePixelRatio = 1.0;
//
//   void setRegions(List<Rect> rects) {
//     _regions
//       ..clear()
//       ..addAll(rects);
//   }
//
//   void start({Duration interval = const Duration(milliseconds: 20)}) {
//     _timer ??= Timer.periodic(interval, (_) => _tick());
//   }
//
//   void stop() {
//     _timer?.cancel();
//     _timer = null;
//   }
//
//   Future<void> _tick() async {
//     // 1) 전역 커서 좌표(물리 px) → 창 로컬(논리 px)
//     final pt = calloc<win.POINT>();
//     win.GetCursorPos(pt);
//     final cursorScreenPhysical = Offset(pt.ref.x.toDouble(), pt.ref.y.toDouble());
//     calloc.free(pt);
//
//     // window_manager는 보통 '논리 px' 반환
//     final winPos = await WindowManagerPlus.current.getPosition(); // Offset(logical)
//     final cursorScreenLogical = cursorScreenPhysical / devicePixelRatio;
//     final local = cursorScreenLogical - winPos;
//
//     // 2) 어떤 인터랙티브 영역에 포함?
//     final inside = _regions.any((r) => r.contains(local));
//
//     // 3) 상태 변화시에만 토글
//     final shouldIgnore = !inside;
//     if (shouldIgnore != _ignoring) {
//       _ignoring = shouldIgnore;
//       // forwardToParent=true: 이벤트를 뒤 창으로 넘김
//       await WindowManagerPlus.current.setIgnoreMouseEvents(shouldIgnore, forward: true);
//     }
//   }
// }
