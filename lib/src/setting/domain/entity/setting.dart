import 'package:blog/src/core/key_constant.dart';

/// This long name is adopted to segregate
/// this in project's domain entity with
/// enum [Thememode] in flutter material library.
enum SettingThememode {
  system,
  light,
  dark,
}

/// This long name is for coherence with [SettingThememode]
enum SettingLanguage {
  english(kLanguageEnglishCode),
  korean(kLanguageKoreanCode);

  const SettingLanguage(this.code);
  final String code;
}

class Setting {
  const Setting({
    required this.themeMode,
    required this.language,
  });

  final SettingThememode themeMode;
  final SettingLanguage language;

  factory Setting.initial() => const Setting(
        themeMode: SettingThememode.system,
        language: SettingLanguage.english,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Setting &&
        other.themeMode == themeMode &&
        other.language == language;
  }

  @override
  int get hashCode => themeMode.hashCode ^ language.hashCode;

  Setting copyWith({
    SettingThememode? themeMode,
    SettingLanguage? language,
  }) {
    return Setting(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
    );
  }
}
