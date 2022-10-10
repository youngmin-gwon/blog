import 'package:blog/src/core/domain/entity/failure.dart';
import 'package:blog/src/setting/application/setting_event.dart';
import 'package:blog/src/setting/application/setting_state.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:blog/src/setting/domain/usecase/change_language.dart';
import 'package:blog/src/setting/domain/usecase/load_setting.dart';
import 'package:blog/src/setting/domain/usecase/change_thememode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingStateNotifier extends StateNotifier<SettingState> {
  SettingStateNotifier({
    required this.loadSetting,
    required this.changeThememode,
    required this.changeLanguage,
  }) : super(const SettingState.stable());

  final ChangeThememode changeThememode;
  final ChangeLanguage changeLanguage;
  final LoadSetting loadSetting;

  SettingEvent? currentEvent;

  Setting setting = Setting.initial();
  Failure? failure;

  Future<void> mapEventToState(SettingEvent event) async {
    currentEvent = event;
    await nextState();
  }

  Future<void> nextState() async {
    await state.nextState(this);
  }

  void setState(SettingState newState) {
    state = newState;
  }
}
