import 'dart:convert';

import 'package:blog/src/core/constant.dart';
import 'package:blog/src/settings/domain/entity/setting.dart';

class SettingDTO {
  const SettingDTO({
    required this.themeMode,
    required this.langCode,
  });

  final String themeMode;
  final String langCode;

  factory SettingDTO.fromDomain(Setting domain) {
    return SettingDTO(themeMode: domain.themeMode, langCode: domain.langCode);
  }

  factory SettingDTO.initial() {
    return const SettingDTO(
      themeMode: kDefaultThememode,
      langCode: kLanguageEnglishCode,
    );
  }

  Setting toDomain() {
    return Setting(themeMode: themeMode, langCode: langCode);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingDTO &&
        runtimeType == other.runtimeType &&
        other.themeMode == themeMode &&
        other.langCode == langCode;
  }

  @override
  int get hashCode => themeMode.hashCode;

  SettingDTO copyWith({
    String? themeMode,
    String? langCode,
  }) {
    return SettingDTO(
      themeMode: themeMode ?? this.themeMode,
      langCode: langCode ?? this.langCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'themeMode': themeMode,
      'langCode': langCode,
    };
  }

  factory SettingDTO.fromMap(Map<String, dynamic> map) {
    return SettingDTO(
      themeMode: map['themeMode'] ?? kDefaultThememode,
      langCode: map['langCode'] ?? kLanguageEnglishCode,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingDTO.fromJson(String source) =>
      SettingDTO.fromMap(json.decode(source));
}
