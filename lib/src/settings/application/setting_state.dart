import 'package:blog/src/settings/application/settings_state_notifier.dart';

abstract class SettingState {
  const factory SettingState.empty() = SettingEmptyState;
  const factory SettingState.loading() = SettingLoadingState;
  const factory SettingState.loaded() = SettingLoadedState;
  const factory SettingState.saving() = SettingSavingState;
  const factory SettingState.saved() = SettingSavedState;
  const factory SettingState.error() = SettingErrorState;

  Future<void> nextState(SettingStateNotifier context);
}

class SettingEmptyState implements SettingState {
  const SettingEmptyState();

  @override
  Future<void> nextState(SettingStateNotifier context) {
    // TODO: implement nextState
    throw UnimplementedError();
  }
}

class SettingLoadingState implements SettingState {
  const SettingLoadingState();

  @override
  Future<void> nextState(SettingStateNotifier context) {
    // TODO: implement nextState
    throw UnimplementedError();
  }
}

class SettingLoadedState implements SettingState {
  const SettingLoadedState();

  @override
  Future<void> nextState(SettingStateNotifier context) {
    // TODO: implement nextState
    throw UnimplementedError();
  }
}

class SettingSavingState implements SettingState {
  const SettingSavingState();

  @override
  Future<void> nextState(SettingStateNotifier context) {
    // TODO: implement nextState
    throw UnimplementedError();
  }
}

class SettingSavedState implements SettingState {
  const SettingSavedState();

  @override
  Future<void> nextState(SettingStateNotifier context) {
    // TODO: implement nextState
    throw UnimplementedError();
  }
}

class SettingErrorState implements SettingState {
  const SettingErrorState();

  @override
  Future<void> nextState(SettingStateNotifier context) {
    // TODO: implement nextState
    throw UnimplementedError();
  }
}
