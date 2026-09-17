import 'package:flutter/material.dart';

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
}

class AccountProvider extends ChangeNotifier {
  double _balance = 165700.00;
  final List<Transaction> _transactions = [
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
      status: TransactionStatus.successful,
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
      status: TransactionStatus.successful,
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
      status: TransactionStatus.successful,
    ),
  ];

  double get balance => _balance;
  List<Transaction> get transactions => List.unmodifiable(_transactions);

  void addTransaction(Transaction transaction, double amount) {
    _transactions.insert(0, transaction);
    if (transaction.status == TransactionStatus.successful) {
      _balance -= amount;
    }
    notifyListeners();
  }
}
