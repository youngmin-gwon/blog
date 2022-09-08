import 'package:blog/src/core/domain/entity/failure.dart';
import 'package:blog/src/core/domain/entity/no_params.dart';
import 'package:blog/src/core/domain/usecase/usecase.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:blog/src/setting/domain/repository/i_setting_repository.dart';
import 'package:dartz/dartz.dart';

class LoadSetting extends Usecase<Setting, NoParams> {
  final ISettingRepository _repository;

  const LoadSetting({
    required ISettingRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, Setting>> call(NoParams params) async {
    return _repository.loadSetting();
  }
}
