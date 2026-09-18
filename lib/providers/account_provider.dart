import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/models/transaction.dart';

class AccountProvider extends ChangeNotifier {
  static const String _balanceKey = 'account_balance';
  static const String _transactionsKey = 'account_transactions';
  static const double _initialBalance = 165700.00;

  double _balance = _initialBalance;
  String _accountNumber = '7099887766';
  List<Transaction> _transactions = [];
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  double get balance => _balance;
  String get accountNumber => _accountNumber;
  List<Transaction> get transactions => List.unmodifiable(_transactions);

  /// Load cached data from disk.
  Future<void> bootstrap() async {
    await _loadFromPrefs();
    _isInitialized = true;
    notifyListeners();
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
      } else {
        _transactions = _getDefaultTransactions();
      }
    } catch (e) {
      debugPrint('Error loading account data: $e');
      _balance = _initialBalance;
      _transactions = _getDefaultTransactions();
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
