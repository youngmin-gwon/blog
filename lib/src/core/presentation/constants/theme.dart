import 'package:flutter/material.dart';

import 'package:material_color_utilities/blend/blend.dart';

class NoAnimationPageTransitionBuilder extends PageTransitionsBuilder {
  const NoAnimationPageTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

class ThemeProvider extends InheritedWidget {
  const ThemeProvider({
    super.key,
    required this.setting,
    required this.lightDynamic,
    required this.darkDynamic,
    required super.child,
  });

  final ValueNotifier<ThemeSetting> setting;
  final ColorScheme? lightDynamic;
  final ColorScheme? darkDynamic;
  final _pageTransitionsTheme = const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: NoAnimationPageTransitionBuilder(),
      TargetPlatform.macOS: NoAnimationPageTransitionBuilder(),
      TargetPlatform.windows: NoAnimationPageTransitionBuilder(),
    },
  );

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant ThemeProvider oldWidget) {
    return oldWidget.setting != setting;
  }

  ThemeMode get themeMode {
    return setting.value.themeMode;
  }

  ThemeData theme(BuildContext context, [Color? targetColor]) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.light
        ? light(targetColor)
        : dark(targetColor);
  }

  ThemeData light([Color? targetColor]) {
    final colorScheme = _colors(Brightness.light, targetColor);
    return _themeData(ThemeData.light(), colorScheme);
  }

  ThemeData dark([Color? targetColor]) {
    final colorScheme = _colors(Brightness.dark, targetColor);
    return _themeData(ThemeData.dark(), colorScheme);
  }

  ColorScheme _colors(Brightness brightness, Color? targetColor) {
    final dynamicPrimary = brightness == Brightness.light
        ? lightDynamic?.primary
        : darkDynamic?.primary;

    return ColorScheme.fromSeed(
      seedColor: dynamicPrimary ?? _source(targetColor),
      brightness: brightness,
    );
  }

  ThemeData _themeData(ThemeData themeData, ColorScheme colorScheme) {
    return themeData.copyWith(
      pageTransitionsTheme: _pageTransitionsTheme,
      colorScheme: colorScheme,
      appBarTheme: _appBarTheme(colorScheme),
      cardTheme: _cardTheme(),
      listTileTheme: _listTileTheme(colorScheme),
      bottomAppBarTheme: _bottomAppBarTheme(colorScheme),
      bottomNavigationBarTheme: _bottomNavigationBarTheme(colorScheme),
      navigationRailTheme: _navigationRailTheme(colorScheme),
      tabBarTheme: _tabBarTheme(colorScheme),
      drawerTheme: _drawerTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.background,
      useMaterial3: true,
    );
  }

  AppBarTheme _appBarTheme(ColorScheme colors) {
    return AppBarTheme(
      elevation: 0,
      backgroundColor: colors.surface,
      foregroundColor: colors.onSurface,
    );
  }

  CardTheme _cardTheme() {
    return CardTheme(
      elevation: 0,
      shape: _shapeMedium,
      clipBehavior: Clip.antiAlias,
    );
  }

  ListTileThemeData _listTileTheme(ColorScheme colors) {
    return ListTileThemeData(
      shape: _shapeMedium,
      selectedColor: colors.secondary,
    );
  }

  ShapeBorder get _shapeMedium => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      );

  BottomAppBarTheme _bottomAppBarTheme(ColorScheme colors) {
    return BottomAppBarTheme(
      color: colors.surface,
      elevation: 0,
    );
  }

  BottomNavigationBarThemeData _bottomNavigationBarTheme(ColorScheme colors) {
    return BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: colors.surfaceVariant,
      selectedItemColor: colors.onSurface,
      unselectedItemColor: colors.onSurfaceVariant,
      elevation: 0,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    );
  }

  NavigationRailThemeData _navigationRailTheme(ColorScheme colors) {
    return const NavigationRailThemeData();
  }

  DrawerThemeData _drawerTheme(ColorScheme colors) {
    return DrawerThemeData(
      backgroundColor: colors.surface,
    );
  }

  TabBarTheme _tabBarTheme(ColorScheme colors) {
    return TabBarTheme(
      labelColor: colors.secondary,
      unselectedLabelColor: colors.onSurfaceVariant,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.secondary,
            width: 2,
          ),
        ),
      ),
    );
  }

  Color custom(CustomColor custom) {
    if (custom.blend) {
      return _blend(custom.color);
    } else {
      return custom.color;
    }
  }

  Color _blend(Color targetColor) {
    return Color(
      Blend.harmonize(targetColor.value, setting.value.sourceColor.value),
    );
  }

  Color _source(Color? target) {
    Color source = setting.value.sourceColor;
    if (target != null) {
      source = _blend(target);
    }
    return source;
  }
}

class ThemeSettingChange extends Notification {
  const ThemeSettingChange({
    required this.setting,
  });

  final ThemeSetting setting;
}

class ThemeSetting {
  const ThemeSetting({
    required this.sourceColor,
    required this.themeMode,
  });

  final Color sourceColor;
  final ThemeMode themeMode;
}

class CustomColor {
  const CustomColor({
    required this.name,
    required this.color,
    this.blend = true,
  });

  final String name;
  final Color color;
  final bool blend;

  Color value(ThemeProvider provider) {
    return provider.custom(this);
  }
}
