import 'package:blog/src/core/domain/entity/failure.dart';
import 'package:blog/src/core/domain/usecase/usecase.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:dartz/dartz.dart';

import 'package:blog/src/setting/domain/repository/i_setting_repository.dart';

class ChangeThememode extends Usecase<Unit, SettingThememode> {
  final ISettingRepository _repository;
  const ChangeThememode({
    required ISettingRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, Unit>> call(SettingThememode params) async {
    return _repository.updateThememode(params);
  }
}
