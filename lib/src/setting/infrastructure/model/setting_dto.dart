import 'dart:convert';

import 'package:blog/src/setting/domain/entity/setting.dart';

class SettingDTO {
  const SettingDTO({
    required this.themeMode,
    required this.language,
  });

  final SettingThememode themeMode;
  final SettingLanguage language;

  factory SettingDTO.fromDomain(Setting domain) {
    return SettingDTO(themeMode: domain.themeMode, language: domain.language);
  }

  factory SettingDTO.initial() => SettingDTO.fromDomain(Setting.initial());

  Setting toDomain() {
    return Setting(themeMode: themeMode, language: language);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingDTO &&
        other.themeMode == themeMode &&
        other.language == language;
  }

  SettingDTO copyWith({
    SettingThememode? themeMode,
    SettingLanguage? language,
  }) {
    return SettingDTO(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'themeMode': themeMode.name,
      'language': language.name,
    };
  }

  factory SettingDTO.fromMap(Map<String, dynamic> map) {
    return SettingDTO(
      themeMode: SettingThememode.values
          .byName(map['themeMode'] ?? SettingThememode.system.name),
      language: SettingLanguage.values
          .byName(map['language'] ?? SettingLanguage.english.name),
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingDTO.fromJson(String source) =>
      SettingDTO.fromMap(json.decode(source));

  @override
  int get hashCode => themeMode.hashCode ^ language.hashCode;
}
