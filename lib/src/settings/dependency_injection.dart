import 'package:blog/src/settings/application/setting_state.dart';
import 'package:blog/src/settings/application/setting_state_notifier.dart';
import 'package:blog/src/settings/domain/repository/i_settings_repository.dart';
import 'package:blog/src/settings/domain/usecase/load_setting.dart';
import 'package:blog/src/settings/domain/usecase/change_thememode.dart';
import 'package:blog/src/settings/infrastructure/datasource/local/settings_local_hive_service.dart';
import 'package:blog/src/settings/infrastructure/datasource/setting_local_service.dart';
import 'package:blog/src/settings/infrastructure/repository/setting_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

//! Application
final settingStateNotifierProvider =
    StateNotifierProvider<SettingStateNotifier, SettingState>(
  (ref) => SettingStateNotifier(
    loadSetting: ref.watch(loadSettingProvider),
    updateThememode: ref.watch(changeThememodeProvider),
  ),
);

//! Usecases
final loadSettingProvider = Provider(
  (ref) => LoadSetting(
    repository: ref.watch(settingRepositoryProvider),
  ),
);

final changeThememodeProvider = Provider(
  (ref) => ChangeThememode(
    repository: ref.watch(settingRepositoryProvider),
  ),
);

//! Repository
final settingRepositoryProvider = Provider<ISettingRepository>(
  (ref) => SettingRepository(
    localService: ref.watch(settingHiveServiceProvider),
  ),
);

//! Datasource
final settingHiveServiceProvider = Provider<SettingLocalService>(
  (ref) => SettingLocalHiveService(storage: ref.watch(hiveStringBoxProvider)),
);

final hiveStringBoxProvider = Provider<Box<String>>(
  (ref) => throw UnimplementedError(),
);
