import 'package:blog/src/setting/domain/entity/setting.dart';

abstract class SettingEvent {
  const factory SettingEvent.loadTheme() = LoadThemeEvent;
  const factory SettingEvent.changeThememode(SettingThememode theme) =
      ChangeThemeModeEvent;
  const factory SettingEvent.changeLanguage(SettingLanguage language) =
      ChangeLanguageEvent;
}

class LoadThemeEvent implements SettingEvent {
  const LoadThemeEvent();
}

class ChangeThemeModeEvent implements SettingEvent {
  const ChangeThemeModeEvent(this.themeMode);

  final SettingThememode themeMode;
}

class ChangeLanguageEvent implements SettingEvent {
  const ChangeLanguageEvent(this.language);

  final SettingLanguage language;
}
