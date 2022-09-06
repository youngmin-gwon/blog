import 'package:blog/src/core/domain/entities/exceptions.dart';
import 'package:blog/src/core/domain/entities/failure.dart';
import 'package:blog/src/settings/domain/entities/setting.dart';
import 'package:blog/src/settings/infrastructure/datasources/setting_service.dart';
import 'package:dartz/dartz.dart';

import 'package:blog/src/settings/domain/repositories/i_settings_repository.dart';

class SettingRepository implements ISettingRepository {
  final SettingService _service;

  const SettingRepository({
    required SettingService service,
  }) : _service = service;

  @override
  Future<Either<Failure, Setting>> loadTheme() async {
    try {
      return Right((await _service.themeMode).toDomain());
    } on InternalCacheException catch (e) {
      return Left(Failure.internal(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTheme(String themeMode) async {
    try {
      await _service.updateThemeMode(themeMode);
      return const Right(unit);
    } on InternalCacheException catch (e) {
      return Left(Failure.internal(e.message));
    }
  }
}
