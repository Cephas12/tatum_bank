import 'package:flutter/material.dart';

class NotificationDetailScreen extends StatelessWidget {
  const NotificationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0B192C)),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Notification Detail',
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // Top Circle Icon Badge
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFEF9C3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.wifi_rounded,
                        color: Color(0xFFCA8A04),
                        size: 38,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Header Title
                    const Text(
                      'Data Purchase Successful',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B192C),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Amount Display
                    const Text(
                      '–₦1,000.00',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0B192C),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Transaction Summary Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        children: [
                          const _DetailItemRow(
                            label: 'Recipient',
                            value: '08012345678',
                          ),
                          const SizedBox(height: 16),
                          const _DetailItemRow(
                            label: 'Network',
                            value: 'MTN Nigeria',
                          ),
                          const SizedBox(height: 16),
                          const _DetailItemRow(
                            label: 'Plan',
                            value: '1.5GB Monthly',
                          ),
                          const SizedBox(height: 16),
                          const _DetailItemRow(
                            label: 'Date',
                            value: '28 May 2024, 10:45 AM',
                          ),
                          const SizedBox(height: 16),

                          // Status Row with Badge
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Status',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF8A94A6),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF6FF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.circle,
                                      size: 6,
                                      color: Color(0xFF2563EB),
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'Successful',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2563EB),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                          ),

                          // Reference Row
                          const _DetailItemRow(
                            label: 'Reference',
                            value: 'TXN-982347123',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Done Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.maybePop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC727),
                    foregroundColor: const Color(0xFF0B192C),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailItemRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailItemRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF8A94A6),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B192C),
          ),
        ),
      ],
    );
  }
}