import 'package:flutter/material.dart';

class SecurityPrivacyScreen extends StatefulWidget {
  const SecurityPrivacyScreen({super.key});

  @override
  State<SecurityPrivacyScreen> createState() => _SecurityPrivacyScreenState();
}

class _SecurityPrivacyScreenState extends State<SecurityPrivacyScreen> {
  bool _isBiometricEnabled = true;
  bool _isTwoFactorEnabled = false;

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
                    'Security & Privacy',
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
                  // Security Group
                  const Text(
                    'Security',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B192C),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        _buildListTile(
                          icon: Icons.shield_outlined,
                          title: 'Change Password',
                          onTap: () {},
                        ),
                        _buildDivider(),
                        _buildListTile(
                          icon: Icons.info_outline_rounded,
                          title: 'Change Transaction PIN',
                          onTap: () {},
                        ),
                        _buildDivider(),
                        _buildSwitchTile(
                          icon: Icons.face_rounded,
                          title: 'Biometric Authentication',
                          value: _isBiometricEnabled,
                          onChanged: (val) {
                            setState(() => _isBiometricEnabled = val);
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Account Group
                  const Text(
                    'Account',
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
                          icon: Icons.notifications_none_rounded,
                          title: 'Two–Factor Authentication',
                          value: _isTwoFactorEnabled,
                          onChanged: (val) {
                            setState(() => _isTwoFactorEnabled = val);
                          },
                        ),
                        _buildDivider(),
                        _buildListTile(
                          icon: Icons.credit_card_rounded,
                          title: 'Device Management',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Privacy Group
                  const Text(
                    'Privacy',
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
                        _buildListTile(
                          icon: Icons.lock_outline_rounded,
                          iconBgColor: const Color(0xFFFEF9C3),
                          iconColor: const Color(0xFFCA8A04),
                          title: 'Privacy Policy',
                          onTap: () {},
                        ),
                        _buildDivider(),
                        _buildListTile(
                          icon: Icons.remove_red_eye_outlined,
                          title: 'Data Sharing',
                          onTap: () {},
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

  Widget _buildListTile({
    required IconData icon,
    required String title,
    Color iconBgColor = const Color(0xFFEEF2FF),
    Color iconColor = const Color(0xFF4F46E5),
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    Color iconBgColor = const Color(0xFFEEF2FF),
    Color iconColor = const Color(0xFF4F46E5),
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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