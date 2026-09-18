import '../models/account.dart';

abstract interface class AccountRepository {
  Future<List<Account>> getAccounts(String token);
}
