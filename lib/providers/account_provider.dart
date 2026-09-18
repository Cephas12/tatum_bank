import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/repositories/account_repository.dart';
import '../domain/repositories/transaction_repository.dart';

enum TransactionStatus { successful, failed, pending }

class Transaction {
  final String title;
  final String subtitle;
  final String amount;
  final bool isCredit;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final String type;
  final String narration;
  final String reference;
  final String? recipient;
  final TransactionStatus status;

  Transaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isCredit,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    this.type = 'Transfer',
    this.narration = 'Transaction Successful',
    this.reference = 'TRN-8293041',
    this.recipient,
    this.status = TransactionStatus.successful,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'amount': amount,
        'isCredit': isCredit,
        'iconCodePoint': icon.codePoint,
        'bgColorValue': bgColor.value,
        'iconColorValue': iconColor.value,
        'type': type,
        'narration': narration,
        'reference': reference,
        'recipient': recipient,
        'status': status.index,
      };

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        title: json['title'],
        subtitle: json['subtitle'],
        amount: json['amount'],
        isCredit: json['isCredit'],
        icon: IconData(json['iconCodePoint'], fontFamily: 'MaterialIcons'),
        bgColor: Color(json['bgColorValue']),
        iconColor: Color(json['iconColorValue']),
        type: json['type'],
        narration: json['narration'],
        reference: json['reference'],
        recipient: json['recipient'],
        status: TransactionStatus.values[json['status']],
      );
}

class AccountProvider extends ChangeNotifier {
  static const String _balanceKey = 'account_balance';
  static const String _transactionsKey = 'account_transactions';
  static const double _initialBalance = 165700.00;

  final AccountRepository _accountRepo;
  final TransactionRepository _transactionRepo;

  AccountProvider(this._accountRepo, this._transactionRepo);

  double _balance = _initialBalance;
  String _accountId = '';
  String _accountNumber = '7099887766';
  List<Transaction> _transactions = [];
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  double get balance => _balance;
  String get accountNumber => _accountNumber;
  List<Transaction> get transactions => List.unmodifiable(_transactions);

  /// Load cached data first, then refresh from API if token provided
  Future<void> bootstrap([String? authToken]) async {
    await _loadFromPrefs();
    if (authToken != null) {
      await refresh(authToken);
    }
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> refresh(String authToken) async {
    try {
      // 1. Get Accounts
      final accounts = await _accountRepo.getAccounts(authToken);
      if (accounts.isNotEmpty) {
        final mainAccount = accounts.first;
        _balance = mainAccount.balance;
        _accountId = mainAccount.id;
        _accountNumber = mainAccount.accountNumber;
      }

      // 2. Get Transactions
      final remoteTransactions = await _transactionRepo.getTransactions(
        token: authToken,
        accountId: _accountId.isNotEmpty ? _accountId : null,
      );
      
      if (remoteTransactions.isNotEmpty) {
        _transactions = remoteTransactions;
      }

      await _saveToPrefs();
      notifyListeners();
    } catch (e) {
      debugPrint('Error refreshing account data: $e');
    }
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final savedBalance = prefs.getDouble(_balanceKey);
      _balance = savedBalance ?? _initialBalance;

      final String? transactionsJson = prefs.getString(_transactionsKey);
      if (transactionsJson != null) {
        final List<dynamic> decoded = jsonDecode(transactionsJson);
        _transactions = decoded.map((item) => Transaction.fromJson(item)).toList();
      } else if (_transactions.isEmpty) {
        _transactions = _getDefaultTransactions();
      }
    } catch (e) {
      debugPrint('Error loading account data: $e');
    }
  }

  List<Transaction> _getDefaultTransactions() {
    return [
      Transaction(
        title: 'Salary Credit',
        subtitle: '28 May 2024 • 08:35 AM',
        amount: '+ ₦120,000.00',
        isCredit: true,
        icon: Icons.arrow_downward_rounded,
        bgColor: const Color(0xFFE6F4EA),
        iconColor: const Color(0xFF10B981),
        type: 'Credit',
        narration: 'May Monthly Salary',
        reference: 'TRN-7728310',
      ),
      Transaction(
        title: 'Transfer to John Doe',
        subtitle: '27 May 2024 • 04:21 PM',
        amount: '- ₦25,000.00',
        isCredit: false,
        icon: Icons.arrow_upward_rounded,
        bgColor: const Color(0xFFF3E8FF),
        iconColor: const Color(0xFF9333EA),
        type: 'Transfer',
        narration: 'Payment for groceries',
        reference: 'TRN-9021832',
        recipient: 'John Doe',
      ),
      Transaction(
        title: 'Phcn Electricity Bill',
        subtitle: '27 May 2024 • 11:10 AM',
        amount: '- ₦6,500.00',
        isCredit: false,
        icon: Icons.lightbulb_outline_rounded,
        bgColor: const Color(0xFFFFF7ED),
        iconColor: const Color(0xFFEA580C),
        type: 'Utility Bill',
        narration: 'Electricity Token Purchase',
        reference: 'TRN-1102834',
      ),
    ];
  }

  Future<void> _saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_balanceKey, _balance);
      
      final String transactionsJson = jsonEncode(
        _transactions.map((tx) => tx.toJson()).toList(),
      );
      await prefs.setString(_transactionsKey, transactionsJson);
    } catch (e) {
      debugPrint('Error saving account data: $e');
    }
  }

  Future<void> makePurchase({
    required String token,
    required String productId,
    required double amount,
    required Map<String, dynamic> fields,
    required Transaction transaction,
  }) async {
    try {
      // 1. Send to API
      await _transactionRepo.purchaseProduct(
        token: token,
        accountId: _accountId,
        productId: productId,
        amount: amount,
        fields: fields,
      );

      // 2. Add locally for immediate feedback
      _transactions.insert(0, transaction);
      _balance -= amount;
      
      await _saveToPrefs();
      notifyListeners();
    } catch (e) {
      // Record failed transaction locally
      final failedTx = Transaction(
        title: transaction.title,
        subtitle: 'Just now • Failed',
        amount: transaction.amount,
        isCredit: false,
        icon: transaction.icon,
        bgColor: const Color(0xFFFEE2E2),
        iconColor: const Color(0xFFEF4444),
        status: TransactionStatus.failed,
        narration: 'Purchase Failed: $e',
        reference: 'FAIL-${DateTime.now().millisecondsSinceEpoch}',
      );
      _transactions.insert(0, failedTx);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addTransaction(Transaction transaction, double amount) async {
    _transactions.insert(0, transaction);
    if (transaction.status == TransactionStatus.successful) {
      _balance -= amount;
    }
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_balanceKey);
    await prefs.remove(_transactionsKey);
    _balance = _initialBalance;
    _transactions = _getDefaultTransactions();
    _isInitialized = false;
    notifyListeners();
  }
}
