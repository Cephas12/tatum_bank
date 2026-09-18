import '../models/transaction.dart';

abstract interface class TransactionRepository {
  Future<List<Transaction>> getTransactions({
    required String token,
    String? accountId,
    int? pageNumber,
    int? pageSize,
  });

  Future<void> purchaseProduct({
    required String token,
    required String accountId,
    required String productId,
    String? productItemId,
    required double amount,
    required Map<String, dynamic> fields,
  });
}
