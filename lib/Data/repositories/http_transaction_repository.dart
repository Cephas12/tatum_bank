import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../domain/repositories/transaction_repository.dart';
import '../../providers/account_provider.dart';
import '../response_handler.dart';

class HttpTransactionRepository implements TransactionRepository {
  final String baseUrl;
  final http.Client _client;

  HttpTransactionRepository({required this.baseUrl, http.Client? client})
      : _client = client ?? http.Client();

  Map<String, String> _authHeaders(String token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  @override
  Future<List<Transaction>> getTransactions({
    required String token,
    String? accountId,
    int? pageNumber,
    int? pageSize,
  }) {
    return safeCall(() async {
      final queryParams = {
        if (accountId != null) 'AccountId': accountId,
        if (pageNumber != null) 'PageNumber': pageNumber.toString(),
        if (pageSize != null) 'PageSize': pageSize.toString(),
      };
      
      final uri = Uri.parse('$baseUrl/transactions').replace(queryParameters: queryParams);
      
      final response = await _client.get(uri, headers: _authHeaders(token));
      final body = handleResponse(response);
      final List<dynamic> data = (body is Map ? body['data'] : body) ?? [];
      
      return data.map((json) {
        final double amount = (json['amount'] ?? 0).toDouble();
        final bool isCredit = json['type'] == 'Credit' || json['category'] == 'Deposit';
        
        return Transaction(
          title: json['productName'] ?? json['category'] ?? 'Transaction',
          subtitle: json['createdAt'] ?? 'Recently',
          amount: '${isCredit ? '+ ' : '- '} ₦$amount',
          isCredit: isCredit,
          icon: isCredit ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
          bgColor: isCredit ? const Color(0xFFE6F4EA) : const Color(0xFFFEE2E2),
          iconColor: isCredit ? const Color(0xFF10B981) : const Color(0xFFEF4444),
          type: json['category'] ?? 'Payment',
          narration: json['narration'] ?? 'Transaction Successful',
          reference: json['reference'] ?? json['id'] ?? 'TRN-000',
          recipient: json['fields']?['phone'] ?? json['fields']?['accountNumber'],
          status: _parseStatus(json['status']),
        );
      }).toList();
    });
  }

  @override
  Future<void> purchaseProduct({
    required String token,
    required String accountId,
    required String productId,
    String? productItemId,
    required double amount,
    required Map<String, dynamic> fields,
  }) {
    return safeCall(() async {
      final response = await _client.post(
        Uri.parse('$baseUrl/transactions/purchase'),
        headers: _authHeaders(token),
        body: jsonEncode({
          'accountId': accountId,
          'productId': productId,
          'productItemId': productItemId,
          'amount': amount,
          'fields': fields,
        }),
      );
      handleResponse(response);
    });
  }

  TransactionStatus _parseStatus(dynamic status) {
    final s = status?.toString().toLowerCase();
    if (s == 'successful' || s == 'success') return TransactionStatus.successful;
    if (s == 'failed') return TransactionStatus.failed;
    return TransactionStatus.pending;
  }
}
