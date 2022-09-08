import 'package:blog/src/core/key_constant.dart';

enum SettingThememode {
  system,
  light,
  dark,
}

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
