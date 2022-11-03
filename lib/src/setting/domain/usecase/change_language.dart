import 'package:blog/src/core/domain/entity/failure.dart';
import 'package:blog/src/core/domain/usecase/usecase.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:blog/src/setting/domain/repository/setting_repository.dart';
import 'package:dartz/dartz.dart';

class ChangeLanguage implements Usecase<Unit, Language> {
  const ChangeLanguage({
    required SettingRepository repository,
  }) : _repository = repository;

  final SettingRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(Language params) async {
    return _repository.updateLanguage(params);
  }
}
