import 'package:blog/src/core/domain/entities/failure.dart';
import 'package:blog/src/settings/application/setting_event.dart';
import 'package:blog/src/settings/application/setting_state.dart';
import 'package:blog/src/settings/domain/entity/setting.dart';
import 'package:blog/src/settings/domain/usecase/load_theme.dart';
import 'package:blog/src/settings/domain/usecase/update_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingStateNotifier extends StateNotifier<SettingState> {
  SettingStateNotifier({
    required this.loadTheme,
    required this.updateTheme,
  }) : super(const SettingState.stable());

  final UpdateTheme updateTheme;
  final LoadTheme loadTheme;

  SettingEvent? currentEvent;

  Setting setting = const Setting(themeMode: "system");
  Failure? failure;

  Future<void> mapEventToState(SettingEvent event) async {
    currentEvent = event;
    await nextState();
  }

  Future<void> nextState() async {
    await state.nextState(this);

    if (state is SettingLoadingState || state is SettingSavingState) {
      await state.nextState(this);
    }
  }

  void setState(SettingState newState) {
    state = newState;
  }

  void branchSavingAndLoading() {
    switch (currentEvent.runtimeType) {
      case LoadThemeEvent:
        setState(const SettingState.loading());
        break;
      case UpdateThemeModeEvent:
        setState(const SettingState.saving());
        break;
    }
  }
}
