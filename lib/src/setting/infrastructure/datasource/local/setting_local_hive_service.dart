import 'package:blog/src/core/domain/entity/exception.dart';
import 'package:blog/src/core/domain/entity/failure.dart';
import 'package:blog/src/core/key_constant.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:blog/src/setting/infrastructure/datasource/setting_local_service.dart';
import 'package:blog/src/setting/infrastructure/model/setting_dto.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingLocalHiveService implements SettingLocalService {
  const SettingLocalHiveService({
    required Box<String> storage,
  }) : _storage = storage;

  final Box<String> _storage;

  @override
  Future<SettingDTO> get setting async {
    try {
      final settingJsonString = _storage.get(kSettingValueKey);

      if (settingJsonString == null) {
        return SettingDTO.initial();
      }

      return SettingDTO.fromJson(settingJsonString);
    } catch (e) {
      throw const InternalCacheException(Failure.cache);
    }
  }

  @override
  Future<void> saveThememode(SystemTheme themeMode) async {
    _trySaving(
      () async {
        final newSetting = (await setting).copyWith(themeMode: themeMode);
        _save(newSetting.toJson());
      },
    );
  }

  @override
  Future<void> saveLanguageSetting(Language language) async {
    _trySaving(
      () async {
        final newSetting = (await setting).copyWith(language: language);
        _save(newSetting.toJson());
      },
    );
  }

  Future<void> _trySaving(Future<void> Function() save) async {
    try {
      await save();
    } catch (e) {
      throw const InternalCacheException(Failure.cache);
    }
  }

  Future<void> _save(String rawSetting) async {
    _storage.put(kSettingValueKey, rawSetting);
  }
}
