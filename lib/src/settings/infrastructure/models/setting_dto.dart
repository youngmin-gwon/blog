import 'dart:convert';

import 'package:blog/src/settings/domain/entities/setting.dart';

class SettingDTO {
  final String themeMode;
  const SettingDTO({
    required this.themeMode,
  });
  factory SettingDTO.fromDomain(Setting domain) {
    return SettingDTO(themeMode: domain.themeMode);
  }

  Setting toDomain() {
    return Setting(themeMode: themeMode);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingDTO && other.themeMode == themeMode;
  }

  @override
  int get hashCode => themeMode.hashCode;

  SettingDTO copyWith({
    String? themeMode,
  }) {
    return SettingDTO(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'themeMode': themeMode,
    };
  }

  factory SettingDTO.fromMap(Map<String, dynamic> map) {
    return SettingDTO(
      themeMode: map['themeMode'] ?? 'system',
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingDTO.fromJson(String source) =>
      SettingDTO.fromMap(json.decode(source));
}
