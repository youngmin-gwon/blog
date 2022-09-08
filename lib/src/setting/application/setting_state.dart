import 'package:blog/src/core/domain/entity/no_params.dart';
import 'package:blog/src/setting/application/setting_event.dart';
import 'package:blog/src/setting/application/setting_state_notifier.dart';

abstract class SettingState {
  const factory SettingState.stable() = SettingStableState;
  const factory SettingState.loading() = SettingLoadingState;
  const factory SettingState.saving() = SettingSavingState;
  const factory SettingState.error() = SettingErrorState;

  Future<void> nextState(SettingStateNotifier context);
}

class SettingStableState implements SettingState {
  const SettingStableState();

  @override
  Future<void> nextState(SettingStateNotifier context) async {
    context.branchSavingAndLoading();
  }
}

class SettingLoadingState implements SettingState {
  const SettingLoadingState();

  @override
  Future<void> nextState(SettingStateNotifier context) async {
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

class SettingSavingState implements SettingState {
  const SettingSavingState();

  @override
  Future<void> nextState(SettingStateNotifier context) async {
    final previousSetting = context.setting.copyWith();
    final themeMode = (context.currentEvent as UpdateThemeModeEvent).themeMode;

    context.setting = previousSetting.copyWith(themeMode: themeMode);

    final resultsOrFailure = await context.updateThememode(themeMode);
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

class SettingErrorState implements SettingState {
  const SettingErrorState();

  @override
  Future<void> nextState(SettingStateNotifier context) async {
    context.branchSavingAndLoading();
  }
}
