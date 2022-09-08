import 'package:blog/src/core/constant.dart';

class Setting {
  const Setting({
    required this.themeMode,
    required this.langCode,
  });

  final String themeMode;
  final String langCode;

  factory Setting.initial() => const Setting(
        themeMode: kDefaultThememode,
        langCode: kLanguageEnglishCode,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Setting &&
        other.themeMode == themeMode &&
        other.langCode == langCode;
  }

  @override
  int get hashCode => themeMode.hashCode ^ langCode.hashCode;

  Setting copyWith({
    String? themeMode,
    String? langCode,
  }) {
    return Setting(
      themeMode: themeMode ?? this.themeMode,
      langCode: langCode ?? this.langCode,
    );
  }
}
