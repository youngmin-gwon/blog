import 'package:blog/src/core/domain/entities/exceptions.dart';
import 'package:blog/src/core/domain/entities/failure.dart';
import 'package:blog/src/settings/domain/entity/setting.dart';
import 'package:blog/src/settings/infrastructure/datasource/setting_local_service.dart';
import 'package:dartz/dartz.dart';

import 'package:blog/src/settings/domain/repository/i_settings_repository.dart';

class SettingRepository implements ISettingRepository {
  final SettingLocalService _localService;

  const SettingRepository({
    required SettingLocalService localService,
  }) : _localService = localService;

  @override
  Future<Either<Failure, Setting>> loadSetting() async {
    try {
      return Right((await _localService.setting).toDomain());
    } on InternalCacheException catch (e) {
      return Left(Failure.internal(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateThememode(String themeMode) async {
    return _updateSettingValue(() => _localService.saveThemeMode(themeMode));
  }

  @override
  Future<Either<Failure, Unit>> updateLanguage(String langCode) async {
    return _updateSettingValue(
        () => _localService.saveLanguageSetting(langCode));
  }

  Future<Either<Failure, Unit>> _updateSettingValue(
      Future<void> Function() onWhichValue) async {
    try {
      await onWhichValue();
      return const Right(unit);
    } on InternalCacheException catch (e) {
      return Left(Failure.internal(e.message));
    }
  }
}
