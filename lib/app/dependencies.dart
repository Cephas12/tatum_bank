import 'package:http/http.dart' as http;
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/account_repository.dart';
import '../domain/repositories/transaction_repository.dart';
import '../Data/repositories/http_auth_repository.dart';
import '../Data/repositories/http_account_repository.dart';
import '../Data/repositories/http_transaction_repository.dart';
import 'app_config.dart';

class Dependencies {
  final AuthRepository authRepository;
  final AccountRepository accountRepository;
  final TransactionRepository transactionRepository;

  const Dependencies._({
    required this.authRepository,
    required this.accountRepository,
    required this.transactionRepository,
  });

  factory Dependencies.resolve() {
    final client = http.Client();
    final baseUrl = AppConfig.apiBaseUrl;

    return Dependencies._(
      authRepository: HttpAuthRepository(baseUrl: baseUrl, client: client),
      accountRepository: HttpAccountRepository(baseUrl: baseUrl, client: client),
      transactionRepository: HttpTransactionRepository(baseUrl: baseUrl, client: client),
    );
  }
}
