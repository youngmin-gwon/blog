import 'package:blog/src/core/constant.dart';
import 'package:blog/src/settings/infrastructure/datasource/setting_local_service.dart';
import 'package:blog/src/settings/infrastructure/model/setting_dto.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingLocalHiveService implements SettingLocalService {
  const SettingLocalHiveService({
    required Box<String> storage,
  }) : _storage = storage;

  final Box<String> _storage;

  @override
  Future<SettingDTO> get setting async {
    final settingsJsonString = _storage.get(kSettingValueKey);

    return SettingDTO.fromJson(
        settingsJsonString ?? SettingDTO.initial().toJson());
  }

  @override
  Future<void> saveThemeMode(String themeMode) async {
    _storage.put(kSettingValueKey,
        (await setting).copyWith(themeMode: themeMode).toJson());
  }

  @override
  Future<void> saveLanguageSetting(String langCode) async {
    _storage.put(kSettingValueKey, (await setting).copyWith().toJson());
  }
}
