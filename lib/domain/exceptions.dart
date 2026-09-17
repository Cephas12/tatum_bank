
sealed class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection.']);
}

class UnauthorisedException extends AppException {
  const UnauthorisedException([super.message = 'Session expired. Please log in.']);
}

class ForbiddenException extends AppException {
  const ForbiddenException([super.message = 'You do not have permission.']);
}

class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Resource not found.']);
}

class ValidationException extends AppException {
  final Map<String, String> errors;
  const ValidationException(super.message, {this.errors = const {}});
}

class TimeoutException extends AppException {
  const TimeoutException([super.message = 'Request timed out. Check your connection.']);
}

class ServerException extends AppException {
  final int statusCode;
  const ServerException(super.message, this.statusCode);
}
