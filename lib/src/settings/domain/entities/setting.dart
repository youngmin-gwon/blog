class Setting {
  final String themeMode;
  const Setting({
    required this.themeMode,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Setting && other.themeMode == themeMode;
  }

  @override
  int get hashCode => themeMode.hashCode;

  Setting copyWith({
    String? themeMode,
  }) {
    return Setting(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
