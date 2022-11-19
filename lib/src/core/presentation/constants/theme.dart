import 'package:flutter/material.dart';

import 'package:material_color_utilities/blend/blend.dart';

import '../generated/fonts.gen.dart';

class ThemeConstant {
  const ThemeConstant._();

  // Todo(ymkwon): select theme color
  static const primaryColor = Colors.indigo;
  static const secondaryColor = Colors.amber;
  static const tertiaryColor = Colors.red;
}

class AppTheme {
  const AppTheme._();

  static final light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: ThemeConstant.primaryColor,
    fontFamily: FontFamily.maruburi,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ThemeConstant.primaryColor,
    fontFamily: FontFamily.maruburi,
  );
}

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

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant ThemeProvider oldWidget) {
    return oldWidget.setting != setting;
  }

  Color custom(CustomColor custom) {
    if (custom.blend) {
      return blend(custom.color);
    } else {
      return custom.color;
    }
  }

  Color blend(Color targetColor) {
    return Color(
        Blend.harmonize(targetColor.value, setting.value.sourceColor.value));
  }

  Color source(Color? target) {
    Color source = setting.value.sourceColor;
    if (target != null) {
      source = blend(target);
    }
    return source;
  }

  ColorScheme colors(Brightness brightness, Color? targetColor) {
    final dynamicPrimary = brightness == Brightness.light
        ? lightDynamic?.primary
        : darkDynamic?.primary;

    return ColorScheme.fromSeed(
      seedColor: dynamicPrimary ?? source(targetColor),
      brightness: brightness,
    );
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
