import 'package:flutter/material.dart';
import '../Transactions/buy_airtime_data_screen.dart';
import 'notification_detail_screen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0B192C)),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B192C),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: Color(0xFF0B192C)),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            // TODAY Section
            const Text(
              'TODAY',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8A94A6),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),

            // Notification 1: Data Purchase
            _NotificationCard(
              icon: Icons.wifi_rounded,
              iconBgColor: Color(0xFFFEF9C3),
              iconColor: Color(0xFFCA8A04),
              title: 'Data Purchase Successful',
              description: 'You have successfully purchased 1.5GB MTN data for 08012345678.',
              time: '2 mins ago',
              isUnread: true,
              onTap: () => _openDetail(context),
            ),

            const SizedBox(height: 12),

            // Notification 2: Low Balance Alert
            _NotificationCard(
              icon: Icons.account_balance_wallet_outlined,
              iconBgColor: Color(0xFFFEE2E2),
              iconColor: Color(0xFFEF4444),
              title: 'Low Balance Alert',
              description: 'Your wallet balance is below ₦500. Top up now to stay connected.',
              time: '1 hour ago',
              isUnread: true,
              actionLabel: 'Top Up Now',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BuyAirtimeDataScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // YESTERDAY Section
            const Text(
              'YESTERDAY',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8A94A6),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),

            // Notification 3: Security Login
            _NotificationCard(
              icon: Icons.notifications_none_rounded,
              iconBgColor: Color(0xFFEEF2FF),
              iconColor: Color(0xFF4F46E5),
              title: 'New Security Login',
              description: 'Your account was accessed from a new device (iPhone 13). If this wasn\'t you, please change your pin.',
              time: 'Yesterday, 4:20 PM',
              isUnread: false,
              onTap: () => _openDetail(context),
            ),

            const SizedBox(height: 12),

            // Notification 4: Weekend Offer
            _NotificationCard(
              icon: Icons.card_giftcard_rounded,
              iconBgColor: Color(0xFFF3E8FF),
              iconColor: Color(0xFF9333EA),
              title: 'Exclusive Weekend Offer',
              description: 'Get 10% cashback on all airtime purchases above ₦2,000 this weekend.',
              time: 'Yesterday, 10:15 AM',
              isUnread: false,
              onTap: () => _openDetail(context),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _openDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotificationDetailScreen(),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final String description;
  final String time;
  final bool isUnread;
  final String? actionLabel;
  final VoidCallback? onTap;

  const _NotificationCard({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.time,
    required this.isUnread,
    this.actionLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Circle
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),

          const SizedBox(width: 12),

          // Content Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title & Blue Unread Indicator Dot
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0B192C),
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(left: 8, top: 4),
                        decoration: const BoxDecoration(
                          color: Color(0xFF2563EB),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 4),

                // Description
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),

                const SizedBox(height: 10),

                // Time & Action Button Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                    if (actionLabel != null)
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          actionLabel!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2563EB),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }
}