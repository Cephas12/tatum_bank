class Account {
  final String id;
  final String customerId;
  final String accountNumber;
  final String accountType;
  final double balance;
  final String currency;
  final String status;
  final DateTime createdAt;

  Account({
    required this.id,
    required this.customerId,
    required this.accountNumber,
    required this.accountType,
    required this.balance,
    required this.currency,
    required this.status,
    required this.createdAt,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] ?? json['accountId'] ?? '',
      customerId: json['customerId'] ?? '',
      accountNumber: json['accountNumber'] ?? '7099887766',
      accountType: json['accountType'] ?? 'Savings Account',
      balance: (json['balance'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'NGN',
      status: json['status'] ?? 'Active',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}
