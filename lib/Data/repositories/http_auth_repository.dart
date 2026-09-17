import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/exceptions.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../response_handler.dart';

class HttpAuthRepository implements AuthRepository {
  final String baseUrl;
  final http.Client _client;

  HttpAuthRepository({required this.baseUrl, http.Client? client})
    : _client = client ?? http.Client();

  Map<String, String> get _headers => const {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Map<String, String> _authHeaders(String token) => {
    ..._headers,
    'Authorization': 'Bearer $token',
  };

  @override
  Future<User> login(String email, String password) {
    return safeCall(() async {
      final response = await _client.post(
        Uri.parse('$baseUrl/Auth/login'),
        headers: _headers,
        body: jsonEncode({'email': email, 'password': password}),
      );
      final body = handleResponse(response) as Map<String, dynamic>;
      final user = User.fromJson(body['data'] as Map<String, dynamic>? ?? body);
      if (user.token.isEmpty) {
        throw const ServerException(
          'The server did not return an access token.',
          200,
        );
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', user.token);
      return user;
    });
  }

  @override
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) {
    return safeCall(() async {
      final response = await _client.post(
        Uri.parse('$baseUrl/Auth/register'),
        headers: _headers,
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'phone': phone,
          'password': password,
        }),
      );
      handleResponse(response);
    });
  }

  @override
  Future<void> verifyRegistration(String email, String otp) {
    return safeCall(() async {
      final response = await _client.post(
        Uri.parse('$baseUrl/Auth/verify-registration'),
        headers: _headers,
        body: jsonEncode({'email': email, 'otp': otp}),
      );
      handleResponse(response);
    });
  }

  @override
  Future<void> resendRegistrationOtp(String email) {
    return safeCall(() async {
      final response = await _client.post(
        Uri.parse('$baseUrl/Auth/resend-registration-otp'),
        headers: _headers,
        body: jsonEncode({'email': email}),
      );
      handleResponse(response);
    });
  }

  @override
  Future<void> startPasswordReset(String email) {
    return safeCall(() async {
      final response = await _client.post(
        Uri.parse('$baseUrl/Auth/reset-password-start'),
        headers: _headers,
        body: jsonEncode({'email': email}),
      );
      handleResponse(response);
    });
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) {
    return safeCall(() async {
      final response = await _client.post(
        Uri.parse('$baseUrl/Auth/reset-password'),
        headers: _headers,
        body: jsonEncode({
          'email': email,
          'otp': otp,
          'newPassword': newPassword,
        }),
      );
      handleResponse(response);
    });
  }

  @override
  Future<void> logout(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    final response = await _client
        .post(Uri.parse('$baseUrl/Auth/logout'), headers: _authHeaders(token))
        .timeout(const Duration(seconds: 5));
    handleResponse(response);
  }

  @override
  Future<User?> restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) return null;

    try {
      final response = await _client
          .get(Uri.parse('$baseUrl/Auth/me'), headers: _authHeaders(token))
          .timeout(const Duration(seconds: 10));
      final body = handleResponse(response) as Map<String, dynamic>;
      final userData = body['data'] as Map<String, dynamic>? ?? body;
      return User.fromJson(userData, fallbackToken: token);
    } on AppException {
      await prefs.remove('auth_token');
      return null;
    }
  }
}
