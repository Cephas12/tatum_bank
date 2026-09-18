import 'package:http/http.dart' as http;
import '../../domain/models/account.dart';
import '../../domain/repositories/account_repository.dart';
import '../response_handler.dart';

class HttpAccountRepository implements AccountRepository {
  final String baseUrl;
  final http.Client _client;

  HttpAccountRepository({required this.baseUrl, http.Client? client})
      : _client = client ?? http.Client();

  Map<String, String> _authHeaders(String token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  @override
  Future<List<Account>> getAccounts(String token) {
    return safeCall(() async {
      final response = await _client.get(
        Uri.parse('$baseUrl/Accounts'),
        headers: _authHeaders(token),
      );
      final body = handleResponse(response);
      final List<dynamic> data = (body is Map ? body['data'] : body) ?? [];
      return data.map((json) => Account.fromJson(json)).toList();
    });
  }
}
