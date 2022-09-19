import 'package:blog/src/setting/application/setting_state.dart';
import 'package:blog/src/setting/application/setting_state_notifier.dart';
import 'package:blog/src/setting/domain/repository/setting_repository.dart';
import 'package:blog/src/setting/domain/usecase/change_language.dart';
import 'package:blog/src/setting/domain/usecase/load_setting.dart';
import 'package:blog/src/setting/domain/usecase/change_thememode.dart';
import 'package:blog/src/setting/infrastructure/datasource/local/setting_local_hive_service.dart';
import 'package:blog/src/setting/infrastructure/datasource/setting_local_service.dart';
import 'package:blog/src/setting/infrastructure/repository/setting_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

//! Application
final settingStateNotifierProvider =
    StateNotifierProvider<SettingStateNotifier, SettingState>(
  (ref) => SettingStateNotifier(
    loadSetting: ref.watch(loadSettingProvider),
    changeThememode: ref.watch(changeThememodeProvider),
    changeLanguage: ref.watch(changeLanguageProvider),
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

final changeLanguageProvider = Provider(
  (ref) => ChangeLanguage(
    repository: ref.watch(settingRepositoryProvider),
  ),
);

//! Repository
final settingRepositoryProvider = Provider<SettingRepository>(
  (ref) => SettingRepositoryImpl(
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
