import 'package:blog/src/core/domain/entities/failure.dart';
import 'package:blog/src/settings/domain/entity/setting.dart';
import 'package:dartz/dartz.dart';

abstract class ISettingRepository {
  Future<Either<Failure, Setting>> loadSetting();
  Future<Either<Failure, Unit>> updateThememode(String themeMode);
  Future<Either<Failure, Unit>> updateLanguage(String langCode);
}
