import '../models/user.dart';

abstract interface class AuthRepository {
  Future<User> login(String email, String password);
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  });
  Future<void> verifyRegistration(String email, String otp);
  Future<void> resendRegistrationOtp(String email);
  Future<void> startPasswordReset(String email);
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });
  Future<void> logout(String token);
  Future<User?> restoreSession();
}
