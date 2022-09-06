// import 'package:blog/src/core/domain/entities/failure.dart';
// import 'package:blog/src/core/domain/entities/no_params.dart';
import 'package:blog/src/settings/application/setting_event.dart';
import 'package:blog/src/settings/application/setting_state.dart';
// import 'package:blog/src/settings/domain/entities/setting.dart';
import 'package:blog/src/settings/domain/usecases/load_theme.dart';
import 'package:blog/src/settings/domain/usecases/update_theme.dart';
// import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingStateNotifier extends StateNotifier<SettingState> {
  SettingStateNotifier({
    required this.loadTheme,
    required this.updateTheme,
  }) : super(const SettingState.empty());

  final UpdateTheme updateTheme;
  final LoadTheme loadTheme;

  Future<void> mapEventToState(SettingEvent event) async {
    // event.when(
    //   loadTheme: () async {
    //     state = const SettingState.loading();
    //     final failureOrResult = await _loadTheme(const NoParams());
    //     state = failureOrResult.fold(
    //       (Failure l) => const SettingState.error(),
    //       (Setting r) => const SettingState.loaded(),
    //     );
    //   },
    //   updateThemeMode: (String theme) async {
    //     state = const SettingState.saving();
    //     final failureOrResult = await _updateTheme(theme);
    //     state = failureOrResult.fold(
    //       (Failure l) => SettingState.error(),
    //       (Unit _) => const SettingState.saved(),
    //     );
    //   },
    // );

    switch (event.runtimeType) {
      case LoadThemeEvent:
        break;
      case UpdateThemeModeEvent:
        break;
    }
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
}
