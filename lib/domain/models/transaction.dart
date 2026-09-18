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

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'amount': amount,
        'isCredit': isCredit,
        // ignore: deprecated_member_use
        'iconCodePoint': icon.codePoint,
        // ignore: deprecated_member_use
        'bgColorValue': bgColor.value,
        // ignore: deprecated_member_use
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
        // ignore: non_const_argument_for_const_parameter
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
