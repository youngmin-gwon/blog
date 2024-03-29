import 'package:blog/src/core/domain/entity/failure.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:dartz/dartz.dart';

abstract class SettingRepository {
  Future<Either<Failure, Setting>> loadSetting();
  Future<Either<Failure, Unit>> updateThememode(SystemTheme themeMode);
  Future<Either<Failure, Unit>> updateLanguage(Language language);
}
