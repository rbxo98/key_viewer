import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:key_viewer_v2/settings/page/setttings_page.dart';

class KeyViewerSettingApp extends StatelessWidget {
  const KeyViewerSettingApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark, // 설정 화면은 다크 고정
      darkTheme: settingsDarkTheme(),
      home: const KeyViewerSettingsPage(),
    );
  }

}

/// Settings 전용 팔레트/치수 상수
abstract class SettingsTokens {
  // Colors
  static const Color bg        = Color(0xFF1B1D20);
  static const Color surface   = Color(0xFF202124);
  static const Color onSurface = Color(0xFFE9EAEC);
  static const Color onSurfaceWeak = Color(0xFFBFC3C8);
  static const Color primary   = Color(0xFF7AB8FF); // 포커스/강조
  static const Color secondary = Color(0xFF89D1A9);
  static const Color error     = Color(0xFFFF5C5C);

  // Opacity
  static const double gridLineOpacity   = 0.10;
  static const double fieldFillOpacity  = 0.06;
  static const double hintOpacity       = 0.45;
  static const double hairlineOpacity   = 0.10;
  static const double borderOpacity     = 0.18;
  static const double checkIdleOpacity  = 0.54;
  static const double switchTrackSelOpacity = 0.45;
  static const double iconOpacity       = 0.85;

  // Radii
  static const double rCard   = 12;
  static const double rField  = 10;
  static const double rBtn    = 12;
  static const double rList   = 12;
  static const double rTooltip= 8;

  // Insets / paddings
  static const EdgeInsets btnPad   = EdgeInsets.symmetric(horizontal: 14, vertical: 10);
  static const EdgeInsets btnText  = EdgeInsets.symmetric(horizontal: 8,  vertical: 8);
  static const EdgeInsets fieldPad = EdgeInsets.symmetric(horizontal: 10, vertical: 8);

  // Strokes
  static const double hairline = 1;
}

ThemeData settingsDarkTheme() {
  final cs = const ColorScheme.dark(
    primary: SettingsTokens.primary,
    secondary: SettingsTokens.secondary,
    surface: SettingsTokens.surface,
    background: SettingsTokens.bg,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: SettingsTokens.onSurface,
    onBackground: SettingsTokens.onSurface,
    error: SettingsTokens.error,
    onError: Colors.white,
  );

  final borderSideHairline = BorderSide(
    color: Colors.white.withOpacity(SettingsTokens.hairlineOpacity),
    width: SettingsTokens.hairline,
  );

  final fieldBorderSide = BorderSide(
    color: Colors.white.withOpacity(SettingsTokens.borderOpacity),
    width: SettingsTokens.hairline,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: cs,
    scaffoldBackgroundColor: SettingsTokens.bg,
    applyElevationOverlayColor: true,

    appBarTheme: const AppBarTheme(
      backgroundColor: SettingsTokens.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: SettingsTokens.onSurface,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
      iconTheme: IconThemeData(color: SettingsTokens.onSurface),
    ),

    cardTheme: CardTheme(
      color: SettingsTokens.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SettingsTokens.rCard),
        side: borderSideHairline,
      ),
    ),

    dialogTheme: DialogTheme(
      backgroundColor: SettingsTokens.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SettingsTokens.rCard),
        side: borderSideHairline,
      ),
      titleTextStyle: const TextStyle(
        color: SettingsTokens.onSurface,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    ),

    dividerTheme: DividerThemeData(
      space: 16,
      thickness: SettingsTokens.hairline,
      color: Colors.white.withOpacity(SettingsTokens.hairlineOpacity),
    ),

    listTileTheme: ListTileThemeData(
      iconColor: Colors.white.withOpacity(SettingsTokens.iconOpacity),
      textColor: SettingsTokens.onSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SettingsTokens.rList),
      ),
    ),

    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: SettingsTokens.onSurface, height: 1.25),
      bodySmall: TextStyle(color: SettingsTokens.onSurfaceWeak),
      titleMedium: TextStyle(color: SettingsTokens.onSurface, fontWeight: FontWeight.w600),
      labelLarge: TextStyle(color: SettingsTokens.onSurface, fontWeight: FontWeight.w600),
    ),

    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: Colors.white.withOpacity(SettingsTokens.fieldFillOpacity),
      hintStyle: TextStyle(color: Colors.white.withOpacity(SettingsTokens.hintOpacity)),
      contentPadding: SettingsTokens.fieldPad,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SettingsTokens.rField),
        borderSide: fieldBorderSide,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SettingsTokens.rField),
        borderSide: fieldBorderSide,
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(SettingsTokens.rField)),
        borderSide: BorderSide(color: SettingsTokens.primary, width: SettingsTokens.hairline),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(SettingsTokens.btnPad),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(SettingsTokens.rBtn)),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(SettingsTokens.onSurface),
        side: WidgetStatePropertyAll(
          BorderSide(color: Colors.white.withOpacity(SettingsTokens.hairlineOpacity * 2), width: SettingsTokens.hairline),
        ),
        padding: const WidgetStatePropertyAll(SettingsTokens.btnPad),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(SettingsTokens.rBtn)),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(SettingsTokens.onSurface),
        padding: const WidgetStatePropertyAll(SettingsTokens.btnText),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(SettingsTokens.rField)),
        ),
      ),
    ),

    switchTheme: SwitchThemeData(
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      trackColor: WidgetStateProperty.resolveWith((s) =>
      s.contains(WidgetState.selected)
          ? SettingsTokens.primary.withOpacity(SettingsTokens.switchTrackSelOpacity)
          : Colors.white.withOpacity(SettingsTokens.hairlineOpacity)),
      thumbColor: WidgetStateProperty.resolveWith((s) =>
      s.contains(WidgetState.selected) ? SettingsTokens.primary : Colors.white70),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((s) =>
      s.contains(WidgetState.selected) ? SettingsTokens.primary : Colors.white.withOpacity(SettingsTokens.checkIdleOpacity)),
      side: BorderSide(color: Colors.white.withOpacity(SettingsTokens.hairlineOpacity * 3), width: SettingsTokens.hairline),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((s) =>
      s.contains(WidgetState.selected) ? SettingsTokens.primary : Colors.white.withOpacity(SettingsTokens.checkIdleOpacity)),
    ),

    menuTheme: MenuThemeData(
      style: MenuStyle(
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        backgroundColor: const WidgetStatePropertyAll(SettingsTokens.surface),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SettingsTokens.rCard),
            side: borderSideHairline,
          ),
        ),
      ),
    ),

    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2C30),
        borderRadius: BorderRadius.circular(SettingsTokens.rTooltip),
        border: Border.all(color: Colors.white.withOpacity(SettingsTokens.hairlineOpacity + 0.02)),
      ),
      textStyle: const TextStyle(color: Colors.white),
    ),

    iconTheme: const IconThemeData(color: SettingsTokens.onSurface),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: SettingsTokens.primary),
  );
}
