import 'package:blog/src/core/constant.dart';
import 'package:blog/src/settings/infrastructure/datasource/setting_service.dart';
import 'package:blog/src/settings/infrastructure/model/setting_dto.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingLocalHiveService implements SettingService {
  SettingLocalHiveService({
    required Box<String> storage,
  }) : _storage = storage;

  final Box<String> _storage;

  @override
  Future<SettingDTO> get setting async {
    final settingsJsonString = _storage.get(kSettingStorageKey);

    return SettingDTO.fromJson(
        settingsJsonString ?? const SettingDTO(themeMode: "system").toJson());
  }

  @override
  Future<void> updateThemeMode(String themeMode) async {
    _storage.put(kSettingStorageKey,
        (await setting).copyWith(themeMode: themeMode).toJson());
  }
}
