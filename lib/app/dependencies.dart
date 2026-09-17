import 'package:http/http.dart' as http;
import '../domain/repositories/auth_repository.dart';
import '../Data/repositories/http_auth_repository.dart';
import 'app_config.dart';

class Dependencies {
  final AuthRepository authRepository;

  const Dependencies._({required this.authRepository});

  factory Dependencies.resolve() => Dependencies._(
      authRepository: HttpAuthRepository(
        baseUrl: AppConfig.apiBaseUrl,
        client: http.Client(),
      ),
    );
}
