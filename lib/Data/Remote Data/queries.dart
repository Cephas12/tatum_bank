import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'api_constant.dart' as api;

class Queries {
  // Common headers helper
  static Map<String, String> _headers([String? token]) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };

  // ─── Auth ───────────────────────────────────────────────
  static Future<dynamic> doLogin({
    required String email,
    required String password,
  }) async {
    Uri url = Uri.parse(api.APIRoute.login);
    debugPrint('==> Login URL: $url');

    final body = {'email': email, 'password': password};
    final response = await http.post(
      url,
      headers: _headers(),
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  static Future<dynamic> register({required Map<String, dynamic> data}) async {
    Uri url = Uri.parse(api.APIRoute.register);
    final response = await http.post(url, headers: _headers(), body: jsonEncode(data));
    return _handleResponse(response, 'Failed to register');
  }

  static Future<dynamic> verifyRegistration({required Map<String, dynamic> data}) async {
    Uri url = Uri.parse(api.APIRoute.verifyRegistration);
    final response = await http.post(url, headers: _headers(), body: jsonEncode(data));
    return _handleResponse(response, 'Failed to verify registration');
  }

  static Future<dynamic> resendRegistrationOtp({required String email}) async {
    Uri url = Uri.parse(api.APIRoute.resendRegistrationOtp);
    final response = await http.post(url, headers: _headers(), body: jsonEncode({'email': email}));
    return _handleResponse(response, 'Failed to resend OTP');
  }

  static Future<dynamic> getMe({required String token}) async {
    Uri url = Uri.parse(api.APIRoute.me);
    final response = await http.get(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to fetch current user');
  }

  static Future<dynamic> adminInvite({required Map<String, dynamic> data, required String token}) async {
    Uri url = Uri.parse(api.APIRoute.adminInvite);
    final response = await http.post(url, headers: _headers(token), body: jsonEncode(data));
    return _handleResponse(response, 'Failed to send admin invite');
  }

  static Future<dynamic> setPassword({required Map<String, dynamic> data}) async {
    Uri url = Uri.parse(api.APIRoute.setPassword);
    final response = await http.post(url, headers: _headers(), body: jsonEncode(data));
    return _handleResponse(response, 'Failed to set password');
  }

  static Future<dynamic> resetPasswordStart({required String email}) async {
    Uri url = Uri.parse(api.APIRoute.resetPasswordStart);
    final response = await http.post(url, headers: _headers(), body: jsonEncode({'email': email}));
    return _handleResponse(response, 'Failed to initiate password reset');
  }

  static Future<dynamic> resetPassword({required Map<String, dynamic> data}) async {
    Uri url = Uri.parse(api.APIRoute.resetPassword);
    final response = await http.post(url, headers: _headers(), body: jsonEncode(data));
    return _handleResponse(response, 'Failed to reset password');
  }

  static Future<dynamic> changePassword({required Map<String, dynamic> data, required String token}) async {
    Uri url = Uri.parse(api.APIRoute.changePassword);
    final response = await http.post(url, headers: _headers(token), body: jsonEncode(data));
    return _handleResponse(response, 'Failed to change password');
  }

  // ─── Notifications ──────────────────────────────────────
  static Future<dynamic> getNotifications({required String token}) async {
    Uri url = Uri.parse(api.APIRoute.notifications);
    final response = await http.get(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to fetch notifications');
  }

  static Future<dynamic> getUnreadNotifications({required String token}) async {
    Uri url = Uri.parse(api.APIRoute.unreadNotifications);
    final response = await http.get(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to fetch unread notifications');
  }

  static Future<dynamic> getUnreadNotificationsCount({required String token}) async {
    Uri url = Uri.parse(api.APIRoute.unreadNotificationsCount);
    final response = await http.get(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to fetch unread notification count');
  }

  static Future<dynamic> getNotificationById({required String id, required String token}) async {
    Uri url = Uri.parse(api.APIRoute.notificationById(id));
    final response = await http.get(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to fetch notification detail');
  }

  static Future<dynamic> markNotificationRead({required String id, required String token}) async {
    Uri url = Uri.parse(api.APIRoute.markNotificationRead(id));
    final response = await http.patch(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to mark notification as read');
  }

  static Future<dynamic> markAllNotificationsRead({required String token}) async {
    Uri url = Uri.parse(api.APIRoute.markAllNotificationsRead);
    final response = await http.patch(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to mark all notifications as read');
  }

  // ─── Products ───────────────────────────────────────────
  static Future<dynamic> getBillers({required String token}) async {
    Uri url = Uri.parse(api.APIRoute.billers);
    final response = await http.get(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to fetch billers');
  }

  static Future<dynamic> getBillerById({required String id, required String token}) async {
    Uri url = Uri.parse(api.APIRoute.billerById(id));
    final response = await http.get(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to fetch biller details');
  }

  static Future<dynamic> getProductsByBiller({required String billerId, required String token}) async {
    Uri url = Uri.parse(api.APIRoute.productsByBiller(billerId));
    final response = await http.get(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to fetch products for biller');
  }

  static Future<dynamic> getProductById({required String id, required String token}) async {
    Uri url = Uri.parse(api.APIRoute.productById(id));
    final response = await http.get(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to fetch product');
  }

  static Future<dynamic> getProductItems({required String productId, required String token}) async {
    Uri url = Uri.parse(api.APIRoute.productItems(productId));
    final response = await http.get(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to fetch product items');
  }

  // ─── Reporting ──────────────────────────────────────────
  static Future<dynamic> getAdminSummary({required String token}) async {
    Uri url = Uri.parse(api.APIRoute.adminSummary);
    final response = await http.get(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to fetch admin summary');
  }

  // ─── ServiceRequests ────────────────────────────────────
  static Future<dynamic> getServiceRequests({required String token}) async {
    Uri url = Uri.parse(api.APIRoute.serviceRequests);
    final response = await http.get(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to fetch service requests');
  }

  static Future<dynamic> getServiceRequestByReference({required String reference, required String token}) async {
    Uri url = Uri.parse(api.APIRoute.serviceRequestByReference(reference));
    final response = await http.get(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to fetch service request by reference');
  }

  // ─── Transactions ───────────────────────────────────────
  static Future<dynamic> createPurchaseTransaction({required Map<String, dynamic> data, required String token}) async {
    Uri url = Uri.parse(api.APIRoute.purchaseTransaction);
    final response = await http.post(url, headers: _headers(token), body: jsonEncode(data));
    return _handleResponse(response, 'Failed to complete purchase transaction');
  }

  static Future<dynamic> getTransactions({required String token}) async {
    Uri url = Uri.parse(api.APIRoute.transactions);
    final response = await http.get(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to fetch transactions');
  }

  // ─── Users ──────────────────────────────────────────────
  static Future<dynamic> getUsers({required String token}) async {
    Uri url = Uri.parse(api.APIRoute.users);
    final response = await http.get(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to fetch users');
  }

  static Future<dynamic> getUserProfile({required String token}) async {
    Uri url = Uri.parse(api.APIRoute.userProfile);
    final response = await http.get(url, headers: _headers(token));
    return _handleResponse(response, 'Failed to fetch user profile');
  }

  // ─── WeatherForecast (Test Endpoint) ────────────────────
  static Future<dynamic> getWeatherForecast() async {
    Uri url = Uri.parse(api.APIRoute.weatherForecast);
    final response = await http.get(url, headers: _headers());
    return _handleResponse(response, 'Failed to fetch weather forecast');
  }

  // Helper method to process responses
  static dynamic _handleResponse(http.Response response, String errorContext) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else {
      throw Exception('$errorContext [${response.statusCode}]: ${response.body}');
    }
  }
}