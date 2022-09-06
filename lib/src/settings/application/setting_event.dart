abstract class SettingEvent {
  const factory SettingEvent.loadTheme() = LoadThemeEvent;
  const factory SettingEvent.updateThemeMode(String theme) =
      UpdateThemeModeEvent;
}

class LoadThemeEvent implements SettingEvent {
  const LoadThemeEvent();
}

class UpdateThemeModeEvent implements SettingEvent {
  const UpdateThemeModeEvent(this.theme);

  final String theme;
}
