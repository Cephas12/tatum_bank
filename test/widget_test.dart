// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:tatum_bank/domain/models/user.dart';
import 'package:tatum_bank/domain/repositories/auth_repository.dart';
import 'package:tatum_bank/main.dart';
import 'package:tatum_bank/providers/auth_provider.dart';

void main() {
  testWidgets('starts with the onboarding screen when no session exists', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AuthProvider(_FakeAuthRepository()),
        child: const MyApp(),
      ),
    );

    await tester.pump();

    expect(find.text('Banking that\nkeeps you smiling'), findsOneWidget);
  });
}

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<User> login(String email, String password) =>
      throw UnimplementedError();

  @override
  Future<void> logout(String token) async {}

  @override
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) async {}

  @override
  Future<void> resendRegistrationOtp(String email) async {}

  @override
  Future<void> startPasswordReset(String email) async {}

  @override
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {}

  @override
  Future<User?> restoreSession() async => null;

  @override
  Future<void> verifyRegistration(String email, String otp) async {}
}
