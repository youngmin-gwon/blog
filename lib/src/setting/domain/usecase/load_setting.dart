import 'package:blog/src/core/domain/entity/failure.dart';
import 'package:blog/src/core/domain/entity/no_params.dart';
import 'package:blog/src/core/domain/usecase/usecase.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:blog/src/setting/domain/repository/setting_repository.dart';
import 'package:dartz/dartz.dart';

class LoadSetting implements Usecase<Setting, NoParams> {
  final SettingRepository _repository;

  const LoadSetting({
    required SettingRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, Setting>> call(NoParams params) async {
    return _repository.loadSetting();
  }
}
