class ServerException implements Exception {}

class InternalCacheException implements Exception {
  const InternalCacheException({
    required this.message,
  });

  final String message;
}
