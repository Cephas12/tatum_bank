class APIRoute {
  static const String baseUrl =
      'https://tatumconnect-backend.onrender.com/api/v1';

  // Base URL without /v1 — used for Products endpoints
  static const String baseUrlNoV1 =
      'https://tatumconnect-backend.onrender.com/api';

  // Root URL — used for WeatherForecast
  static const String rootUrl = 'https://tatumconnect-backend.onrender.com';

  // ─── Auth ───────────────────────────────────────────────
  static String register = '$baseUrl/Auth/register';
  static String verifyRegistration = '$baseUrl/Auth/verify-registration';
  static String resendRegistrationOtp = '$baseUrl/Auth/resend-registration-otp';
  static String login = '$baseUrl/Auth/login';
  static String me = '$baseUrl/Auth/me';
  static String adminInvite = '$baseUrl/Auth/admin/invite';
  static String setPassword = '$baseUrl/Auth/set-password';
  static String resetPasswordStart = '$baseUrl/Auth/reset-password-start';
  static String resetPassword = '$baseUrl/Auth/reset-password';
  static String changePassword = '$baseUrl/Auth/change-password';

  // ─── Notifications ──────────────────────────────────────
  static String notifications = '$baseUrl/Notifications';
  static String unreadNotifications = '$baseUrl/Notifications/unread';
  static String unreadNotificationsCount =
      '$baseUrl/Notifications/unread/count';
  static String notificationById(String id) => '$baseUrl/Notifications/$id';
  static String markNotificationRead(String id) =>
      '$baseUrl/Notifications/$id/read';
  static String markAllNotificationsRead = '$baseUrl/Notifications/read-all';

  // ─── Products ───────────────────────────────────────────
  static String billers = '$baseUrlNoV1/Products/billers';
  static String billerById(String id) => '$baseUrlNoV1/Products/billers/$id';
  static String productsByBiller(String billerId) =>
      '$baseUrlNoV1/Products/billers/$billerId/products';
  static String productById(String id) => '$baseUrlNoV1/Products/$id';
  static String productItems(String productId) =>
      '$baseUrlNoV1/Products/$productId/items';

  // ─── Reporting ──────────────────────────────────────────
  static String adminSummary = '$baseUrl/Reporting/admin/summary';

  // ─── ServiceRequests ────────────────────────────────────
  static String serviceRequests = '$baseUrl/ServiceRequests';
  static String serviceRequestByReference(String reference) =>
      '$baseUrl/ServiceRequests/by-reference/$reference';

  // ─── Transactions ───────────────────────────────────────
  static String purchaseTransaction = '$baseUrl/transactions/purchase';
  static String transactions = '$baseUrl/transactions';

  // ─── Users ──────────────────────────────────────────────
  static String users = '$baseUrl/Users';
  static String userProfile = '$baseUrl/Users/profile';

  // ─── WeatherForecast (test endpoint) ────────────────────
  static String weatherForecast = '$rootUrl/WeatherForecast';
}