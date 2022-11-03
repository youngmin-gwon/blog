import 'package:blog/src/core/domain/entity/no_params.dart';
import 'package:blog/src/setting/application/setting_state.dart';
import 'package:blog/src/setting/application/setting_state_notifier.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';

abstract class SettingEvent {
  const factory SettingEvent.loadTheme() = LoadThemeEvent;
  const factory SettingEvent.changeThememode(SettingThemeMode theme) =
      ChangeThemeModeEvent;
  const factory SettingEvent.changeLanguage(Language language) =
      ChangeLanguageEvent;

  void setToEachState(SettingStateNotifier context);
  Future<void> processToState(SettingStateNotifier context);
}

class LoadThemeEvent implements SettingEvent {
  const LoadThemeEvent();

  @override
  void setToEachState(SettingStateNotifier context) {
    context.setState(const SettingState.loading());
    context.nextState();
  }

  @override
  Future<void> processToState(SettingStateNotifier context) async {
    final resultsOrFailure = await context.loadSetting(const NoParams());
    resultsOrFailure.fold(
      (l) {
        context.failure = l;
        context.setState(const SettingState.error());
      },
      (r) {
        context.setting = r;
        context.setState(const SettingState.stable());
      },
    );
  }
}

class ChangeThemeModeEvent implements SettingEvent {
  const ChangeThemeModeEvent(this.themeMode);

  final SettingThemeMode themeMode;

  @override
  void setToEachState(SettingStateNotifier context) {
    context.setState(const SettingState.saving());
    context.nextState();
  }

  @override
  Future<void> processToState(SettingStateNotifier context) async {
    final previousSetting = context.setting.copyWith();

    context.setting = previousSetting.copyWith(themeMode: themeMode);

    final resultsOrFailure = await context.changeThememode(themeMode);
    resultsOrFailure.fold(
      (l) {
        context.failure = l;
        context.setting = previousSetting;
        context.setState(const SettingState.error());
      },
      (r) {
        context.setState(const SettingState.stable());
      },
    );
  }
}

class ChangeLanguageEvent implements SettingEvent {
  const ChangeLanguageEvent(this.language);

  final Language language;

  @override
  void setToEachState(SettingStateNotifier context) {
    context.setState(const SettingState.saving());
    context.nextState();
  }

  @override
  Future<void> processToState(SettingStateNotifier context) async {
    final previousSetting = context.setting.copyWith();
    context.setting = previousSetting.copyWith(language: language);

    final resultsOrFailure = await context.changeLanguage(language);
    resultsOrFailure.fold(
      (l) {
        context.failure = l;
        context.setting = previousSetting;
        context.setState(const SettingState.error());
      },
      (r) {
        context.setState(const SettingState.stable());
      },
    );
  }
}
