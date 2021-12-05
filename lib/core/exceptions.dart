class ServerException implements Exception {
  ServerException({
    required this.message,
    required this.errorCode,
  });

  final String message;
  final String errorCode;
}

/// Exceptions thrown from Local data source
class CacheException implements Exception {
  final String message;

  CacheException({required this.message});
}

class CustomPlatformException implements Exception {
  final String message;

  CustomPlatformException({required this.message});
}
