import 'package:flutter/material.dart';

class TransactionHomeScreen extends StatefulWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onViewAccountTap;
  final VoidCallback? onQuickActionsTap;
  final VoidCallback? onTransferMoneyTap;
  final VoidCallback? onPayBillsTap;
  final VoidCallback? onBuyAirtimeTap;
  final VoidCallback? onMoreQuickActionsTap;
  final VoidCallback? onInviteFriendsTap;
  final VoidCallback? onViewAllTransactionsTap;
  final Function(int)? onBottomNavTap;

  const TransactionHomeScreen({
    super.key,
    this.onNotificationTap,
    this.onSettingsTap,
    this.onViewAccountTap,
    this.onQuickActionsTap,
    this.onTransferMoneyTap,
    this.onPayBillsTap,
    this.onBuyAirtimeTap,
    this.onMoreQuickActionsTap,
    this.onInviteFriendsTap,
    this.onViewAllTransactionsTap,
    this.onBottomNavTap,
  });

  @override
  State<TransactionHomeScreen> createState() => _TransactionHomeScreenState();
}

class _TransactionHomeScreenState extends State<TransactionHomeScreen> {
  bool _isBalanceVisible = true;
  int _currentBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Profile & Notifications Row (Responsive & Constrained)
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150?img=47',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Hi, Sarima',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0B192C),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text('👋', style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Welcome back! Check your status.',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF8A94A6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Notification Bell with Badge
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.notifications_none_rounded,
                              color: Color(0xFF0B192C),
                              size: 22,
                            ),
                            onPressed: widget.onNotificationTap,
                          ),
                          Positioned(
                            right: -2,
                            top: -2,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: Color(0xFFEF4444),
                                shape: BoxShape.circle,
                              ),
                              child: const Text(
                                '1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.settings_outlined,
                          color: Color(0xFF0B192C),
                          size: 22,
                        ),
                        onPressed: widget.onSettingsTap,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 2. Yellow Balance Card (Constrained widths)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC727),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Flexible(
                                  child: Text(
                                    'Savings Account',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0B192C),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.circle, size: 6, color: Color(0xFF10B981)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'ACCOUNT NUMBER\n7099887766',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B192C),
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.copy_rounded, size: 14, color: Color(0xFF0B192C)),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Balance Amount Row
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            _isBalanceVisible ? '₦165,700.00' : '₦ ••••••••',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0B192C),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isBalanceVisible = !_isBalanceVisible;
                            });
                          },
                          child: Icon(
                            _isBalanceVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 18,
                            color: const Color(0xFF0B192C),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Available Balance',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF475569),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Action Buttons Row inside Balance Card
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 42,
                            child: ElevatedButton(
                              onPressed: widget.onViewAccountTap,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0B192C),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'View Account',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 42,
                            child: ElevatedButton(
                              onPressed: widget.onQuickActionsTap,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF0B192C),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Quick Actions',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 3. Quick Actions Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B192C),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onQuickActionsTap,
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _QuickActionButton(
                    icon: Icons.swap_horiz_rounded,
                    label: 'Transfer\nMoney',
                    onTap: widget.onTransferMoneyTap,
                  ),
                  _QuickActionButton(
                    icon: Icons.receipt_long_rounded,
                    label: 'Pay Bills',
                    onTap: widget.onPayBillsTap,
                  ),
                  _QuickActionButton(
                    icon: Icons.smartphone_rounded,
                    label: 'Buy Airtime',
                    onTap: widget.onBuyAirtimeTap,
                  ),
                  _QuickActionButton(
                    icon: Icons.widgets_outlined,
                    label: 'More',
                    onTap: widget.onMoreQuickActionsTap,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 4. Promo Banner Section
              const Text(
                'Get more out of Tatum',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B192C),
                ),
              ),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: widget.onInviteFriendsTap,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B192C),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Invite your friends',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Invite your friends to download and save on Koins app and start earning.',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF94A3B8),
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.card_giftcard_rounded,
                        color: Color(0xFFFFC727),
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 5. Recent Transactions Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B192C),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onViewAllTransactionsTap,
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: const [
                    _TransactionTile(
                      icon: Icons.arrow_downward_rounded,
                      iconBgColor: Color(0xFFDCFCE7),
                      iconColor: Color(0xFF16A34A),
                      title: 'Salary Credit',
                      date: '28 May 2024 • 08:35 AM',
                      amount: '+ ₦120,000.00',
                      isCredit: true,
                    ),
                    Divider(height: 1, color: Color(0xFFF1F5F9)),
                    _TransactionTile(
                      icon: Icons.arrow_upward_rounded,
                      iconBgColor: Color(0xFFF3E8FF),
                      iconColor: Color(0xFF9333EA),
                      title: 'Transfer to John Doe',
                      date: '27 May 2024 • 04:15 PM',
                      amount: '- ₦25,000.00',
                      isCredit: false,
                    ),
                    Divider(height: 1, color: Color(0xFFF1F5F9)),
                    _TransactionTile(
                      icon: Icons.receipt_rounded,
                      iconBgColor: Color(0xFFFFEDD5),
                      iconColor: Color(0xFFEA580C),
                      title: 'Phcn Electricity Bill',
                      date: '27 May 2024 • 11:10 AM',
                      amount: '- ₦6,500.00',
                      isCredit: false,
                    ),
                    Divider(height: 1, color: Color(0xFFF1F5F9)),
                    _TransactionTile(
                      icon: Icons.receipt_rounded,
                      iconBgColor: Color(0xFFFFEDD5),
                      iconColor: Color(0xFFEA580C),
                      title: 'Phcn Electricity Bill',
                      date: '27 May 2024 • 11:10 AM',
                      amount: '- ₦2,500.00',
                      isCredit: false,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        onTap: (index) {
          setState(() {
            _currentBottomNavIndex = index;
          });
          if (widget.onBottomNavTap != null) {
            widget.onBottomNavTap!(index);
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF0B192C),
        unselectedItemColor: const Color(0xFF94A3B8),
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz_rounded),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.headset_mic_outlined),
            label: 'Support',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_rounded),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets_outlined),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Icon(icon, color: const Color(0xFF0B192C), size: 22),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0B192C),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final String date;
  final String amount;
  final bool isCredit;

  const _TransactionTile({
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
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
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
                    color: Color(0xFF8A94A6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B192C),
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Successful',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF8A94A6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}