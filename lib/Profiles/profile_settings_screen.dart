import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'edit_profile_screen.dart';
import 'notification_preferences_screen.dart';
import 'security_privacy_screen.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    final auth = context.watch<AuthProvider>();
    final user = auth.user;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: topPadding + 12),

          // 1. App Bar
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
                    'Profile & Settings',
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

          // 2. Main Scrollable Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Profile Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC727),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: const Color(0xFF0B192C),
                          child: Text(
                            user.initials,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0B192C),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                user.email,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF475569),
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                '0805 123 4567',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF475569),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfileScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit_outlined, size: 14),
                          label: const Text('Edit'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0B192C),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Account Information Section
                  const Text(
                    'Account Information',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B192C),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildAccountRow('Account Number', '7099887766',
                            hasCopy: true),
                        const SizedBox(height: 14),
                        _buildAccountRow('Account Type', 'Savings Account'),
                        const SizedBox(height: 14),
                        _buildAccountRow('BVN', '**** **** 3456',
                            hasVisibilityToggle: true),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Status',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCFCE7),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Active',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF16A34A),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Settings Section
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B192C),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Column(
                      children: [
                        _buildSettingTile(
                          icon: Icons.shield_outlined,
                          iconBgColor: const Color(0xFFEEF2FF),
                          iconColor: const Color(0xFF4F46E5),
                          title: 'Security & Privacy',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SecurityPrivacyScreen(),
                              ),
                            );
                          },
                        ),
                        _buildDivider(),
                        _buildSettingTile(
                          icon: Icons.notifications_none_rounded,
                          iconBgColor: const Color(0xFFEEF2FF),
                          iconColor: const Color(0xFF4F46E5),
                          title: 'Notification Preferences',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const NotificationPreferencesScreen(),
                              ),
                            );
                          },
                        ),
                        _buildDivider(),
                        _buildSettingTile(
                          icon: Icons.credit_card_rounded,
                          iconBgColor: const Color(0xFFEEF2FF),
                          iconColor: const Color(0xFF4F46E5),
                          title: 'Linked Accounts',
                        ),
                        _buildDivider(),
                        _buildSettingTile(
                          icon: Icons.lock_outline_rounded,
                          iconBgColor: const Color(0xFFFEF9C3),
                          iconColor: const Color(0xFFCA8A04),
                          title: 'Help & Support',
                        ),
                        _buildDivider(),
                        _buildSettingTile(
                          icon: Icons.info_outline_rounded,
                          iconBgColor: const Color(0xFFEEF2FF),
                          iconColor: const Color(0xFF4F46E5),
                          title: 'About Tatum Bank',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Log Out Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton.icon(
                      onPressed: () {
                        auth.logout();
                        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                      },
                      icon: const Icon(
                        Icons.logout_rounded,
                        color: Color(0xFFEF4444),
                        size: 18,
                      ),
                      label: const Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEF4444),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFFEF2F2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
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

  Widget _buildAccountRow(
      String label,
      String value, {
        bool hasCopy = false,
        bool hasVisibilityToggle = false,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF64748B),
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B192C),
              ),
            ),
            if (hasCopy) ...[
              const SizedBox(width: 6),
              const Icon(
                Icons.copy_rounded,
                size: 14,
                color: Color(0xFF94A3B8),
              ),
            ],
            if (hasVisibilityToggle) ...[
              const SizedBox(width: 6),
              const Icon(
                Icons.visibility_outlined,
                size: 16,
                color: Color(0xFF94A3B8),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 18,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0B192C),
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFCBD5E1),
              size: 20,
            ),
          ],
        ),
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