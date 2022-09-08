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
      final settingsJsonString = _storage.get(kSettingValueKey);

      return SettingDTO.fromJson(
          settingsJsonString ?? SettingDTO.initial().toJson());
    } catch (e) {
      throw const InternalCacheException(Failure.cache);
    }
  }

  @override
  Future<void> saveThememode(SettingThememode themeMode) async {
    _try(
      () async {
        _storage.put(kSettingValueKey,
            (await setting).copyWith(themeMode: themeMode).toJson());
      },
    );
  }

  @override
  Future<void> saveLanguageSetting(SettingLanguage language) async {
    _try(
      () async {
        _storage.put(kSettingValueKey,
            (await setting).copyWith(language: language).toJson());
      },
    );
  }

  Future<void> _try(Future<void> Function() function) async {
    try {
      await function();
    } catch (e) {
      throw const InternalCacheException(Failure.cache);
    }
  }
}
