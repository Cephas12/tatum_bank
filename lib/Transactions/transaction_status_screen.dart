import 'package:flutter/material.dart';

class TransactionStatusScreen extends StatelessWidget {
  final bool isSuccess;
  final String amount;
  final String networkName;
  final String networkColorHex;
  final String plan;
  final String recipient;
  final String? transactionId;
  final String? error;
  final VoidCallback? onPrimaryAction; // "Done" or "Try Again"
  final VoidCallback? onSecondaryAction; // "Share Receipt" or "Back to Home"

  const TransactionStatusScreen({
    super.key,
    required this.isSuccess,
    required this.amount,
    required this.networkName,
    required this.plan,
    required this.recipient,
    this.networkColorHex = '0xFFFFC727',
    this.transactionId,
    this.error,
    this.onPrimaryAction,
    this.onSecondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
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
                Expanded(
                  child: Text(
                    isSuccess ? 'Transaction Successful' : 'Transaction Failed',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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

          // 2. Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 24.0,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  // Status Icon Badge
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: isSuccess
                          ? const Color(0xFFD1FAE5)
                          : const Color(0xFFFEE2E2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: isSuccess
                              ? const Color(0xFF10B981)
                              : const Color(0xFFFF0000),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isSuccess ? Icons.check_rounded : Icons.close_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Subtitle Label
                  if (!isSuccess) ...[
                    Text(
                      error ?? "We couldn't process your request at this time.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  Text(
                    isSuccess ? 'AMOUNT PAID' : 'ATTEMPTED AMOUNT',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: Color(0xFF94A3B8),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '₦$amount',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0B192C),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Transaction Details Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Column(
                      children: [
                        // Network Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Network',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: Color(
                                      int.parse(
                                        networkColorHex.replaceAll('#', '0xFF'),
                                      ),
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'M',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  networkName,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0B192C),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                        ),

                        // Plan Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Plan',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            Text(
                              plan,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B192C),
                              ),
                            ),
                          ],
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                        ),

                        // Recipient Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Recipient',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  recipient,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0B192C),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.copy_rounded,
                                  size: 14,
                                  color: Color(0xFFEAB308),
                                ),
                              ],
                            ),
                          ],
                        ),

                        if (isSuccess && transactionId != null) ...[
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Divider(
                              height: 1,
                              color: Color(0xFFF1F5F9),
                            ),
                          ),
                          // Transaction ID Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Transaction ID',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              Text(
                                transactionId!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Need Help Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSuccess
                          ? const Color(0xFFEFF6FF)
                          : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                      border: isSuccess
                          ? null
                          : Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: isSuccess
                                ? const Color(0xFF3B82F6)
                                : const Color(0xFF94A3B8),
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
                                'Need Help?',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0B192C),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'If you encounter any issues, our support team is available 24/7.',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF64748B),
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    isSuccess
                                        ? 'CONTACT SUPPORT'
                                        : 'LEARN MORE',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFD97706),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  const Icon(
                                    Icons.chevron_right,
                                    size: 14,
                                    color: Color(0xFFD97706),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Active Primary Action Button (Done / Try Again)
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: Material(
                      color: const Color(0xFFFFC727),
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: onPrimaryAction ?? () {},
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
                                  Icons.receipt_rounded,
                                  size: 16,
                                  color: Color(0xFF0B192C),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                isSuccess ? 'Done' : 'Try Again',
                                style: const TextStyle(
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

                  const SizedBox(height: 10),

                  // Secondary Action Button (Share Receipt / Back to Home)
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: onSecondaryAction ?? () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isSuccess
                                ? Icons.share_outlined
                                : Icons.home_outlined,
                            size: 16,
                            color: const Color(0xFF0B192C),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isSuccess ? 'Share Receipt' : 'Back to Home',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B192C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}