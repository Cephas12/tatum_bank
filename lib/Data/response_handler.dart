import 'dart:async' as dart_async;
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../domain/exceptions.dart';

dynamic handleResponse(http.Response response) {
  final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;

  switch (response.statusCode) {
    case 200:
    case 201:
      return body;
    case 204:
      return null;
    case 400:
      final msg = _message(body) ?? 'Invalid request.';
      final errors = _fieldErrors(body);
      throw ValidationException(msg, errors: errors);
    case 401:
      throw UnauthorisedException(_message(body) ?? 'Session expired. Please log in.');
    case 403:
      throw ForbiddenException(_message(body) ?? 'You do not have permission.');
    case 404:
      throw NotFoundException(_message(body) ?? 'Resource not found.');
    case 409:
      throw ValidationException(_message(body) ?? 'A conflict occurred.');
    case 422:
      throw ValidationException(
        _message(body) ?? 'Validation failed.',
        errors: _fieldErrors(body),
      );
    case 429:
      throw const NetworkException('Too many attempts. Please wait and try again.');
    default:
      if (response.statusCode >= 500) {
        throw ServerException(
          _message(body) ?? 'Server error. Please try again later.',
          response.statusCode,
        );
      }
      throw ServerException(
        'Unexpected response (${response.statusCode}).',
        response.statusCode,
      );
  }
}

String? _message(dynamic body) {
  if (body is! Map) return null;
  return (body['message'] ?? body['error'] ?? body['detail'])?.toString();
}

Map<String, String> _fieldErrors(dynamic body) {
  if (body is! Map) return {};
  final raw = body['errors'] ?? body['fields'] ?? {};
  if (raw is! Map) return {};
  return raw.map((k, v) => MapEntry(k.toString(), v is List ? v.first.toString() : v.toString()));
}

Future<T> safeCall<T>(Future<T> Function() call) async {
  try {
    return await call().timeout(const Duration(seconds: 15));
  } on SocketException {
    throw const NetworkException();
  } on dart_async.TimeoutException {
    throw const TimeoutException();
  }
}
