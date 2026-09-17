import 'package:flutter/material.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  State<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends State<NotificationPreferencesScreen> {
  // Push Notifications State
  bool _pushTransactionAlerts = true;
  bool _pushSecurityAlerts = true;
  bool _pushAccountActivity = false;

  // Email Notifications State
  bool _emailMonthlyStatements = true;
  bool _emailPromotions = false;
  bool _emailNewsUpdates = false;

  // SMS Notifications State
  bool _smsOtpSecurity = true;
  bool _smsTransactionAlerts = true;

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
              children: [
                GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF0B192C),
                    size: 22,
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Notification Preferences',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B192C),
                    ),
                  ),
                ),
                const SizedBox(width: 22),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 2. Main Scrollable List
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Push Notifications Section
                  const Text(
                    'Push Notifications',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B192C),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Column(
                      children: [
                        _buildSwitchTile(
                          title: 'Transaction Alerts',
                          value: _pushTransactionAlerts,
                          onChanged: (val) {
                            setState(() => _pushTransactionAlerts = val);
                          },
                        ),
                        _buildDivider(),
                        _buildSwitchTile(
                          title: 'Security Alerts',
                          value: _pushSecurityAlerts,
                          onChanged: (val) {
                            setState(() => _pushSecurityAlerts = val);
                          },
                        ),
                        _buildDivider(),
                        _buildSwitchTile(
                          title: 'Account Activity',
                          value: _pushAccountActivity,
                          onChanged: (val) {
                            setState(() => _pushAccountActivity = val);
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Email Notifications Section
                  const Text(
                    'Email Notifications',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B192C),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Column(
                      children: [
                        _buildSwitchTile(
                          title: 'Monthly Statements',
                          value: _emailMonthlyStatements,
                          onChanged: (val) {
                            setState(() => _emailMonthlyStatements = val);
                          },
                        ),
                        _buildDivider(),
                        _buildSwitchTile(
                          title: 'Promotions & Offers',
                          value: _emailPromotions,
                          onChanged: (val) {
                            setState(() => _emailPromotions = val);
                          },
                        ),
                        _buildDivider(),
                        _buildSwitchTile(
                          title: 'News & Updates',
                          value: _emailNewsUpdates,
                          onChanged: (val) {
                            setState(() => _emailNewsUpdates = val);
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // SMS Notifications Section
                  const Text(
                    'SMS Notifications',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B192C),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Column(
                      children: [
                        _buildSwitchTile(
                          title: 'OTP & Security',
                          value: _smsOtpSecurity,
                          onChanged: (val) {
                            setState(() => _smsOtpSecurity = val);
                          },
                        ),
                        _buildDivider(),
                        _buildSwitchTile(
                          title: 'Transaction Alerts',
                          value: _smsTransactionAlerts,
                          onChanged: (val) {
                            setState(() => _smsTransactionAlerts = val);
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0B192C),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: const Color(0xFFFFC727),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFE2E8F0),
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      color: Color(0xFFF1F5F9),
      indent: 16,
      endIndent: 16,
    );
  }
}