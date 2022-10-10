import 'package:blog/src/core/domain/entity/failure.dart';

abstract class FailureException implements Exception {
  const FailureException._(this.failure);

  final Failure failure;
}

class InternalCacheException extends FailureException {
  const InternalCacheException(Failure failure) : super._(failure);
}
