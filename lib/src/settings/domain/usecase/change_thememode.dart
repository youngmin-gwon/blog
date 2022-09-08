import 'package:blog/src/core/domain/entities/failure.dart';
import 'package:blog/src/core/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import 'package:blog/src/settings/domain/repository/i_settings_repository.dart';

class ChangeThememode extends Usecase<Unit, String> {
  final ISettingRepository _repository;
  const ChangeThememode({
    required ISettingRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, Unit>> call(String params) async {
    return _repository.updateThememode(params);
  }
}
