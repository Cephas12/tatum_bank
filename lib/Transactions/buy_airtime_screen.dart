import 'package:flutter/material.dart';
import 'buy_airtime_data_screen.dart';
import 'TransactionHistory/transaction_history_screen.dart';

class BuyAirtimeScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final Function(String network)? onNetworkSelect;
  final VoidCallback? onViewMoreTap;

  const BuyAirtimeScreen({
    super.key,
    this.onBackTap,
    this.onNetworkSelect,
    this.onViewMoreTap,
  });

  @override
  State<BuyAirtimeScreen> createState() => _BuyAirtimeScreenState();
}

class _BuyAirtimeScreenState extends State<BuyAirtimeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _networks = [
    {'name': 'MTN', 'color': '0xFFFFC727', 'textColor': '0xFF000000'},
    {'name': 'Airtel', 'color': '0xFFED1C24', 'textColor': '0xFFFFFFFF'},
    {'name': 'Glo', 'color': '0xFF00A859', 'textColor': '0xFFFFFFFF'},
    {'name': '9mobile', 'color': '0xFF004028', 'textColor': '0xFFFFFFFF'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Top status bar padding height
    final double topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // 1. Full-bleed Yellow Header (Covers Status Bar Area)
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: topPadding + 8.0,
              bottom: 14.0,
              left: 16.0,
              right: 16.0,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFFFC727),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: widget.onBackTap ?? () => Navigator.maybePop(context),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFDB72),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF0B192C),
                      size: 20,
                    ),
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Buy Airtime',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B192C),
                    ),
                  ),
                ),
                const SizedBox(width: 36), // Balance space for symmetry
              ],
            ),
          ),

          // 2. Main Content Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Select Network Header
                  const Text(
                    'SELECT NETWORK',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Color(0xFF0B192C),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Network Selection Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _networks.map((net) {
                      return GestureDetector(
                        onTap: () {
                          if (widget.onNetworkSelect != null) {
                            widget.onNetworkSelect!(net['name']!);
                            return;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const BuyAirtimeDataScreen(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Color(int.parse(net['color']!)),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  net['name']!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    color: Color(int.parse(net['textColor']!)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              net['name']!,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Search History Input
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(fontSize: 13),
                      decoration: const InputDecoration(
                        hintText: 'Search history',
                        hintStyle: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 13,
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Color(0xFF94A3B8),
                          size: 20,
                        ),
                        suffixIcon: Icon(
                          Icons.calendar_month_outlined,
                          color: Color(0xFF0B192C),
                          size: 18,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Recent Transactions Header
                  const Text(
                    'RECENT AIRTIME TRANSACTIONS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Color(0xFF0B192C),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Transactions List
                  const _AirtimeTile(
                    icon: Icons.smartphone_rounded,
                    iconBgColor: Color(0xFFFEF3C7),
                    iconColor: Color(0xFFD97706),
                    title: 'Buy Airtime - MTN',
                    date: 'Successful • Today, 10:45 AM',
                    amount: '- ₦2,000.00',
                    isCredit: false,
                  ),
                  const _AirtimeTile(
                    icon: Icons.arrow_downward_rounded,
                    iconBgColor: Color(0xFFD1FAE5),
                    iconColor: Color(0xFF059669),
                    title: 'Share Airtime - Glo',
                    date: 'Successful • Today, 09:12 AM',
                    amount: '- ₦500.00',
                    isCredit: false,
                  ),
                  const _AirtimeTile(
                    icon: Icons.account_balance_wallet_rounded,
                    iconBgColor: Color(0xFFFFE4E6),
                    iconColor: Color(0xFFE11D48),
                    title: 'Airtime Received - Airtel',
                    date: 'Successful • Today, 08:05 AM',
                    amount: '+ ₦1,000.00',
                    isCredit: true,
                  ),
                  const _AirtimeTile(
                    icon: Icons.water_drop_rounded,
                    iconBgColor: Color(0xFFE0F2FE),
                    iconColor: Color(0xFF0284C7),
                    title: 'Buy Airtime - 9mobile',
                    date: 'Successful • Today, 07:20 AM',
                    amount: '- ₦3,000.00',
                    isCredit: false,
                  ),
                  const _AirtimeTile(
                    icon: Icons.send_rounded,
                    iconBgColor: Color(0xFFE0E7FF),
                    iconColor: Color(0xFF4F46E5),
                    title: 'Data Top-up - MTN',
                    date: 'Successful • Yesterday, 06:45 PM',
                    amount: '- ₦5,000.00',
                    isCredit: false,
                  ),

                  const SizedBox(height: 20),

                  // View More Link
                  Center(
                    child: GestureDetector(
                      onTap: widget.onViewMoreTap ??
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const TransactionHistoryScreen(),
                              ),
                            );
                          },
                      child: const Text(
                        'VIEW MORE ACTIVITIES',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AirtimeTile extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final String date;
  final String amount;
  final bool isCredit;

  const _AirtimeTile({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.date,
    required this.amount,
    required this.isCredit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B192C),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            amount,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isCredit ? const Color(0xFF10B981) : const Color(0xFF0B192C),
            ),
          ),
        ],
      ),
    );
  }
}