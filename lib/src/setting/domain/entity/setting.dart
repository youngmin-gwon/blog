import 'package:blog/src/core/key_constant.dart';

/// This long name is adopted to segregate
/// this in project's domain entity with
/// enum [ThemeMode] in flutter material library.
enum SettingThemeMode {
  system,
  light,
  dark,
}

enum Language {
  system(""),
  english(kLanguageCodeEnglish),
  korean(kLanguageCodeKorean);

  const Language(this.code);
  final String code;
}

class Setting {
  const Setting({
    required this.themeMode,
    required this.language,
  });

  final SettingThemeMode themeMode;
  final Language language;

  factory Setting.initial() => const Setting(
        themeMode: SettingThemeMode.system,
        language: Language.system,
      );

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Setting &&
        other.themeMode == themeMode &&
        other.language == language;
  }

  Setting copyWith({
    SettingThemeMode? themeMode,
    Language? language,
  }) {
    return Setting(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
    );
  }
}
