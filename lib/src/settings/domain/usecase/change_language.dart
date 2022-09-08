import 'package:blog/src/core/domain/entities/failure.dart';
import 'package:blog/src/core/domain/usecases/usecase.dart';
import 'package:blog/src/settings/domain/repository/i_settings_repository.dart';
import 'package:dartz/dartz.dart';

class ChangeLanguage implements Usecase<Unit, String> {
  const ChangeLanguage({
    required ISettingRepository repository,
  }) : _repository = repository;

  final ISettingRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(String params) async {
    // TODO: implement call
    throw UnimplementedError();
  }
}
