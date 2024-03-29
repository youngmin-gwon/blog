import 'dart:convert';

import 'package:blog/src/setting/domain/entity/setting.dart';

class SettingDTO {
  const SettingDTO({
    required this.themeMode,
    required this.language,
  });

  final SystemTheme themeMode;
  final Language language;

  factory SettingDTO.fromDomain(Setting domain) {
    return SettingDTO(themeMode: domain.themeMode, language: domain.language);
  }

  factory SettingDTO.initial() => SettingDTO.fromDomain(Setting.initial());

  Setting toDomain() {
    return Setting(themeMode: themeMode, language: language);
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingDTO &&
        other.themeMode == themeMode &&
        other.language == language;
  }

  SettingDTO copyWith({
    SystemTheme? themeMode,
    Language? language,
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
      themeMode: SystemTheme.values
          .byName(map['themeMode'] ?? SystemTheme.system.name),
      language: Language.values.byName(map['language'] ?? Language.system.name),
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingDTO.fromJson(String source) =>
      SettingDTO.fromMap(json.decode(source));
}
