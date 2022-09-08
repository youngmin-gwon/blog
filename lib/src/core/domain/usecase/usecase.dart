import 'package:blog/src/core/domain/entity/failure.dart';
import 'package:dartz/dartz.dart';

abstract class Usecase<Type, Params> {
  const Usecase();
  Future<Either<Failure, Type>> call(Params params);
}
