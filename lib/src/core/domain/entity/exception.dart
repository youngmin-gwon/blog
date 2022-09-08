import 'package:blog/src/core/domain/entity/failure.dart';

abstract class IException implements Exception {
  const IException._(this.failure);
  final Failure failure;
}

class InternalCacheException extends IException {
  const InternalCacheException(Failure failure) : super._(failure);
}

class ServerException extends IException {
  const ServerException(Failure failure) : super._(failure);
}
