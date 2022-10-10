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
    context.currentEvent?.setToEachState(context);
  }
}

class SettingLoadingState implements SettingState {
  const SettingLoadingState();

  @override
  Future<void> nextState(SettingStateNotifier context) async {
    await context.currentEvent?.processToState(context);
  }
}

class SettingSavingState implements SettingState {
  const SettingSavingState();

  @override
  Future<void> nextState(SettingStateNotifier context) async {
    await context.currentEvent?.processToState(context);
  }
}

class SettingErrorState implements SettingState {
  const SettingErrorState();

  @override
  Future<void> nextState(SettingStateNotifier context) async {
    context.currentEvent?.setToEachState(context);
  }
}
