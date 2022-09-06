import 'package:blog/src/core/domain/entities/failure.dart';
import 'package:blog/src/core/domain/entities/no_params.dart';
import 'package:blog/src/core/domain/usecases/usecase.dart';
import 'package:blog/src/settings/domain/entities/setting.dart';
import 'package:blog/src/settings/domain/repositories/i_settings_repository.dart';
import 'package:dartz/dartz.dart';

class LoadTheme extends Usecase<Setting, NoParams> {
  final ISettingRepository _repository;

  const LoadTheme({
    required ISettingRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, Setting>> call(NoParams params) async {
    return await _repository.loadTheme();
  }
}
