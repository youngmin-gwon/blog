import 'package:blog/src/setting/domain/entity/setting.dart';

abstract class SettingEvent {
  const factory SettingEvent.loadTheme() = LoadThemeEvent;
  const factory SettingEvent.updateThemeMode(SettingThememode theme) =
      UpdateThemeModeEvent;
}

class LoadThemeEvent implements SettingEvent {
  const LoadThemeEvent();
}

class UpdateThemeModeEvent implements SettingEvent {
  const UpdateThemeModeEvent(this.themeMode);

  final SettingThememode themeMode;
}
