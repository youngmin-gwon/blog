import 'package:blog/src/core/domain/entity/exception.dart';
import 'package:blog/src/core/domain/entity/failure.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:blog/src/setting/infrastructure/datasource/setting_local_service.dart';
import 'package:dartz/dartz.dart';

import 'package:blog/src/setting/domain/repository/i_setting_repository.dart';

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
      Future<void> Function() onWhichValue) async {
    try {
      await onWhichValue();
      return const Right(unit);
    } on InternalCacheException catch (e) {
      return Left(e.failure);
    }
  }
}
