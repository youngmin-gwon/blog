import 'package:blog/src/core/domain/entity/failure.dart';
import 'package:blog/src/core/domain/usecase/usecase.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:dartz/dartz.dart';

import 'package:blog/src/setting/domain/repository/setting_repository.dart';

class ChangeThememode implements Usecase<Unit, SystemTheme> {
  final SettingRepository _repository;
  const ChangeThememode({
    required SettingRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, Unit>> call(SystemTheme params) async {
    return _repository.updateThememode(params);
  }
}
