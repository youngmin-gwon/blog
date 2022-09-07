import 'package:blog/src/settings/application/setting_state.dart';
import 'package:blog/src/settings/application/setting_state_notifier.dart';
import 'package:blog/src/settings/domain/repository/i_settings_repository.dart';
import 'package:blog/src/settings/domain/usecase/load_theme.dart';
import 'package:blog/src/settings/domain/usecase/update_theme.dart';
import 'package:blog/src/settings/infrastructure/datasource/local/settings_local_hive_service.dart';
import 'package:blog/src/settings/infrastructure/datasource/setting_service.dart';
import 'package:blog/src/settings/infrastructure/repository/setting_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

//! Application
final settingStateNotifierProvider =
    StateNotifierProvider<SettingStateNotifier, SettingState>(
  (ref) => SettingStateNotifier(
    loadTheme: ref.watch(loadThemeProvider),
    updateTheme: ref.watch(updateThemeProvider),
  ),
);

//! Usecases
final loadThemeProvider = Provider(
  (ref) => LoadTheme(
    repository: ref.watch(settingRepositoryProvider),
  ),
);

final updateThemeProvider = Provider(
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
  (ref) => SettingLocalHiveService(storage: ref.watch(hiveStringBoxProvider)),
);

final hiveStringBoxProvider = Provider<Box<String>>(
  (ref) => throw UnimplementedError(),
);
