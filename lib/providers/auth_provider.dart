import 'package:flutter/foundation.dart';
import '../domain/exceptions.dart';
import '../domain/models/user.dart';
import '../domain/repositories/auth_repository.dart';

enum ViewState { idle, loading, success, empty, error }

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repo;

  AuthProvider(this._repo);

  User? _user;
  ViewState loginState = ViewState.idle;
  ViewState registerState = ViewState.idle;
  ViewState verificationState = ViewState.idle;
  ViewState passwordResetState = ViewState.idle;
  String? errorMessage;
  Map<String, String> fieldErrors = {};

  bool get isLoggedIn => _user != null;
  User get user => _user!;
  String get userName => _user?.name ?? '';

  Future<bool> _run(
    Future<User> Function() action, {
    required void Function(ViewState) setState,
  }) async {
    setState(ViewState.loading);
    errorMessage = null;
    fieldErrors = {};
    notifyListeners();

    try {
      _user = await action();
      setState(ViewState.success);
      notifyListeners();
      return true;
    } on ValidationException catch (e) {
      errorMessage = e.message;
      fieldErrors = e.errors;
      setState(ViewState.error);
    } on UnauthorisedException catch (e) {
      errorMessage = e.message;
      setState(ViewState.error);
    } on NetworkException catch (e) {
      errorMessage = e.message;
      setState(ViewState.error);
    } on TimeoutException catch (e) {
      errorMessage = e.message;
      setState(ViewState.error);
    } catch (e) {
      errorMessage = 'Something went wrong. Please try again.';
      setState(ViewState.error);
    } finally {
      notifyListeners();
    }
    return false;
  }

  Future<bool> login(String email, String password) =>
      _run(() => _repo.login(email, password), setState: (s) => loginState = s);

  Future<bool> _runVoid(
    Future<void> Function() action, {
    required void Function(ViewState) setState,
  }) async {
    setState(ViewState.loading);
    errorMessage = null;
    fieldErrors = {};
    notifyListeners();

    try {
      await action();
      setState(ViewState.success);
      return true;
    } on ValidationException catch (e) {
      errorMessage = e.message;
      fieldErrors = e.errors;
    } on AppException catch (e) {
      errorMessage = e.message;
    } catch (_) {
      errorMessage = 'Something went wrong. Please try again.';
    }

    setState(ViewState.error);
    notifyListeners();
    return false;
  }

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) => _runVoid(
    () => _repo.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      password: password,
    ),
    setState: (s) => registerState = s,
  );

  Future<bool> verifyRegistration(String email, String otp) => _runVoid(
    () => _repo.verifyRegistration(email, otp),
    setState: (s) => verificationState = s,
  );

  Future<bool> resendRegistrationOtp(String email) => _runVoid(
    () => _repo.resendRegistrationOtp(email),
    setState: (s) => verificationState = s,
  );

  Future<bool> startPasswordReset(String email) => _runVoid(
    () => _repo.startPasswordReset(email),
    setState: (s) => passwordResetState = s,
  );

  Future<bool> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) => _runVoid(
    () => _repo.resetPassword(email: email, otp: otp, newPassword: newPassword),
    setState: (s) => passwordResetState = s,
  );

  Future<void> logout() async {
    if (_user == null) return;
    final token = _user!.token;
    _user = null;
    loginState = ViewState.idle;
    notifyListeners();
    await _repo.logout(token);
  }

  Future<void> bootstrap() async {
    loginState = ViewState.loading;
    notifyListeners();
    try {
      _user = await _repo.restoreSession();
      loginState = _user != null ? ViewState.success : ViewState.idle;
    } on AppException catch (e) {
      errorMessage = e.message;
      loginState = ViewState.error;
    } catch (_) {
      errorMessage = 'Unable to restore your session. Please log in again.';
      loginState = ViewState.error;
    }
    notifyListeners();
  }

  String? fieldError(String field) => fieldErrors[field];
}
