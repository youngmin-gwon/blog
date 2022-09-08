import 'package:blog/src/core/domain/entity/failure.dart';
import 'package:blog/src/core/domain/usecase/usecase.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:blog/src/setting/domain/repository/i_setting_repository.dart';
import 'package:dartz/dartz.dart';

class ChangeLanguage implements Usecase<Unit, SettingLanguage> {
  const ChangeLanguage({
    required ISettingRepository repository,
  }) : _repository = repository;

  final ISettingRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(SettingLanguage params) async {
    return _repository.updateLanguage(params);
  }
}
