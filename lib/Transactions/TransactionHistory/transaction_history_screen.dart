import 'package:flutter/material.dart';
import 'transaction_detail_screen.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['All', 'Pending', 'Successful', 'Failed'];

  final List<Map<String, dynamic>> _transactions = [
    {
      'title': 'Buy Airtime – MTN',
      'status': 'Successful',
      'amount': '- ₦2,000.00',
      'time': '10:45 AM',
      'isCredit': false,
      'icon': Icons.wallet,
      'bgColor': const Color(0xFFFEF3C7),
      'iconColor': const Color(0xFFD97706),
    },
    {
      'title': 'Share Airtime – Glo',
      'status': 'Successful',
      'amount': '- ₦500.00',
      'time': '09:12 AM',
      'isCredit': false,
      'icon': Icons.send_rounded,
      'bgColor': const Color(0xFFD1FAE5),
      'iconColor': const Color(0xFF10B981),
    },
    {
      'title': 'Airtime Received - Airtel',
      'status': 'Successful',
      'amount': '+ ₦1,000.00',
      'time': '08:06 AM',
      'isCredit': true,
      'icon': Icons.lightbulb_rounded,
      'bgColor': const Color(0xFFFEE2E2),
      'iconColor': const Color(0xFFEF4444),
    },
    {
      'title': 'Buy Airtime - 9mobile',
      'status': 'Successful',
      'amount': '- ₦3,000.00',
      'time': '07:20 AM',
      'isCredit': false,
      'icon': Icons.smartphone_rounded,
      'bgColor': const Color(0xFFECFDF5),
      'iconColor': const Color(0xFF059669),
    },
    {
      'title': 'Data Top-up – MTN',
      'status': 'Successful',
      'amount': '- ₦5,000.00',
      'time': '06:45 AM',
      'isCredit': false,
      'icon': Icons.arrow_downward_rounded,
      'bgColor': const Color(0xFFFEF3C7),
      'iconColor': const Color(0xFFD97706),
    },
    {
      'title': 'Airtime Refund',
      'status': 'Successful',
      'amount': '+ ₦200.00',
      'time': '05:15 AM',
      'isCredit': true,
      'icon': Icons.water_drop_rounded,
      'bgColor': const Color(0xFFF1F5F9),
      'iconColor': const Color(0xFF94A3B8),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: topPadding + 12),

          // 1. App Bar Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xFF0B192C),
                    size: 20,
                  ),
                ),
                const Text(
                  'Transaction History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B192C),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.tune_rounded,
                    color: Color(0xFF0B192C),
                    size: 22,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 2. Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Balance Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF031B33),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -20,
                          top: -20,
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Savings Account',
                                      style: TextStyle(
                                        color: Color(0xFF94A3B8),
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      '7099887766',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.account_balance_rounded,
                                    color: Color(0xFFEAB308),
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'AVAILABLE BALANCE',
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '₦165,700.00',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Search Bar & Calendar Button
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: 'Search airtime transactions',
                              hintStyle: TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 13,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xFF94A3B8),
                                size: 20,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 46,
                        width: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.calendar_month_outlined,
                          color: Color(0xFF0B192C),
                          size: 20,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Filter Tabs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(_tabs.length, (index) {
                      final isSelected = _selectedTabIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedTabIndex = index),
                        child: Column(
                          children: [
                            Text(
                              _tabs[index],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? const Color(0xFF0B192C)
                                    : const Color(0xFF94A3B8),
                              ),
                            ),
                            const SizedBox(height: 6),
                            if (isSelected)
                              Container(
                                width: 16,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0B192C),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 24),

                  // Date Group Header
                  const Text(
                    'TODAY, 28 MAY 2024',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Color(0xFF94A3B8),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Transactions List
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _transactions.length,
                    separatorBuilder: (context, index) =>
                    const Divider(height: 24, color: Color(0xFFF1F5F9)),
                    itemBuilder: (context, index) {
                      final item = _transactions[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TransactionDetailScreen(),
                            ),
                          );
                        },
                        child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: item['bgColor'] as Color,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              item['icon'] as IconData,
                              color: item['iconColor'] as Color,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'] as String,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0B192C),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item['status'] as String,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                item['amount'] as String,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: (item['isCredit'] as bool)
                                      ? const Color(0xFF10B981)
                                      : const Color(0xFF0B192C),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item['time'] as String,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // View More Activities Button
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'View More Activities',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}