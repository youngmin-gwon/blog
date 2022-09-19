import 'package:blog/src/core/domain/entity/exception.dart';
import 'package:blog/src/core/domain/entity/failure.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:blog/src/setting/infrastructure/datasource/setting_local_service.dart';
import 'package:dartz/dartz.dart';

import 'package:blog/src/setting/domain/repository/setting_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingLocalService _localService;

  const SettingRepositoryImpl({
    required SettingLocalService localService,
  }) : _localService = localService;

  @override
  Future<Either<Failure, Setting>> loadSetting() async {
    try {
      final settingDto = await _localService.setting;
      final settingEntity = settingDto.toDomain();
      return Right(settingEntity);
    } on InternalCacheException catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> updateThememode(
      SettingThememode themeMode) async {
    return _updateSettingValue(() => _localService.saveThememode(themeMode));
  }

  @override
  Future<Either<Failure, Unit>> updateLanguage(SettingLanguage language) async {
    return _updateSettingValue(
        () => _localService.saveLanguageSetting(language));
  }

  Future<Either<Failure, Unit>> _updateSettingValue(
      Future<void> Function() update) async {
    try {
      await update();
      return const Right(unit);
    } on InternalCacheException catch (e) {
      return Left(e.failure);
    }
  }
}
