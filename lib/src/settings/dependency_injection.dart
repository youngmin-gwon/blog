import 'package:blog/src/settings/application/setting_state.dart';
import 'package:blog/src/settings/application/settings_state_notifier.dart';
import 'package:blog/src/settings/domain/entities/setting.dart';
import 'package:blog/src/settings/domain/repositories/i_settings_repository.dart';
import 'package:blog/src/settings/domain/usecases/load_theme.dart';
import 'package:blog/src/settings/domain/usecases/update_theme.dart';
import 'package:blog/src/settings/infrastructure/datasources/local/settings_local_hive_service.dart';
import 'package:blog/src/settings/infrastructure/datasources/setting_service.dart';
import 'package:blog/src/settings/infrastructure/repositories/setting_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//! Presentation
final settingProvider = StateProvider<Setting>(
  (ref) => throw UnimplementedError(),
);

//! Application
final settingStateNotifierProvider =
    StateNotifierProvider<SettingStateNotifier, SettingState>(
  (ref) => SettingStateNotifier(
    loadTheme: ref.watch(loadThemeProvider),
    updateTheme: ref.watch(updateThemeProvider),
  ),
);

//! Usecases
final loadThemeProvider = Provider<LoadTheme>(
  (ref) => LoadTheme(
    repository: ref.watch(settingRepositoryProvider),
  ),
);

final updateThemeProvider = Provider<UpdateTheme>(
  (ref) => UpdateTheme(
    repository: ref.watch(settingRepositoryProvider),
  ),
);

//! Repository
final settingRepositoryProvider = Provider<ISettingRepository>(
  (ref) => SettingRepository(
    service: ref.watch(settingHiveServiceProvider),
  ),
);

//! Datasource
final settingHiveServiceProvider = Provider<SettingService>(
  (ref) => SettingLocalHiveService(),
);
