import 'package:flutter/material.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. Header Bar
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
                  onTap: () => Navigator.maybePop(context),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Colors.white,
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
                    'Transaction Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B192C),
                    ),
                  ),
                ),
                const SizedBox(width: 36),
              ],
            ),
          ),

          // 2. Main Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Status Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        // MTN Logo Circle
                        Container(
                          width: 54,
                          height: 54,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFC727),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              'MTN',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        const Text(
                          'DATA\nPURCHASE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            color: Color(0xFF94A3B8),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),

                        const Text(
                          'MTN Data Purchase',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0B192C),
                          ),
                        ),
                        const SizedBox(height: 6),

                        const Text(
                          '– ₦1,000.00',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0B192C),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Success Badge
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              decoration: const BoxDecoration(
                                color: Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Successful',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        const Text(
                          'Oct 24, 2023 • 10:24 AM',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Section Title
                  const Text(
                    'TRANSACTION INFO',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: Color(0xFF94A3B8),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Info Table Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow('Transaction Type', 'Data Purchase'),
                        _buildDivider(),
                        _buildInfoRow('Amount', '₦1,000.00'),
                        _buildDivider(),
                        _buildInfoRow(
                          'Account Debited',
                          'Savings • 012****345',
                        ),
                        _buildDivider(),
                        _buildInfoRow('Narration', 'MTN 1.5GB Monthly Plan'),
                        _buildDivider(),
                        _buildInfoRow(
                          'Reference Number',
                          'TRN8293041',
                          hasCopy: true,
                        ),
                        _buildDivider(),
                        _buildInfoRow(
                          'Transaction ID',
                          'TAT-90821-XP2',
                          hasCopy: true,
                        ),
                        _buildDivider(),
                        _buildInfoRow('Channel', 'MTN Nigeria'),
                        _buildDivider(),
                        _buildInfoRow('Phone Number', '0803 123 4567'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Need Help Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: Color(0xFF3B82F6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.question_mark_rounded,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Need Help with this?',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0B192C),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'If you have issues with this transaction, our team is here to help.',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF64748B),
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () {},
                                child: const Row(
                                  children: [
                                    Text(
                                      'CONTACT SUPPORT',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFD97706),
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 14,
                                      color: Color(0xFFD97706),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Download Receipt Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: Material(
                      color: const Color(0xFFFFC727),
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.receipt_long_rounded,
                                  size: 16,
                                  color: Color(0xFF0B192C),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Download Receipt',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0B192C),
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.chevron_right,
                                size: 20,
                                color: Color(0xFF0B192C),
                              ),
                            ],
                          ),
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

  Widget _buildInfoRow(
      String label,
      String value, {
        bool hasCopy = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B192C),
                ),
              ),
              if (hasCopy) ...[
                const SizedBox(width: 6),
                const Icon(
                  Icons.copy_rounded,
                  size: 14,
                  color: Color(0xFFEAB308),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      color: Color(0xFFF1F5F9),
    );
  }
}