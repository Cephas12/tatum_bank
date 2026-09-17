import 'package:flutter/material.dart';
import '../app/constants.dart';
import 'transaction_status_screen.dart';

class BuyAirtimeDataScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onContactsTap;
  final Function(Map<String, dynamic> data)? onContinueTap;

  const BuyAirtimeDataScreen({
    super.key,
    this.onBackTap,
    this.onContactsTap,
    this.onContinueTap,
  });

  @override
  State<BuyAirtimeDataScreen> createState() => _BuyAirtimeDataScreenState();
}

class _BuyAirtimeDataScreenState extends State<BuyAirtimeDataScreen> {
  int _selectedNetworkIndex = 0;
  int _selectedServiceIndex = 0; // 0 for Airtime, 1 for Data Bundle
  int _selectedAmountIndex = -1; // -1 means no preset selected
  int _selectedDataBundleIndex = -1;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _customAmountController = TextEditingController();

  final List<Map<String, String>> _networks = [
    {'name': 'MTN', 'color': '0xFFFFC727', 'textColor': '0xFF000000'},
    {'name': 'Airtel', 'color': '0xFFFF8A8A', 'textColor': '0xFFFFFFFF'},
    {'name': 'Glo', 'color': '0xFF81D4FA', 'textColor': '0xFFFFFFFF'},
    {'name': '9mobile', 'color': '0xFF66BB6A', 'textColor': '0xFFFFFFFF'},
  ];

  // Raw numeric values matching preset strings
  final List<String> _presetAmounts = ['500', '1000', '2000'];

  final List<Map<String, String>> _dataBundles = [
    {'plan': '1GB / 1 Day', 'price': '300'},
    {'plan': '2.5GB / 2 Days', 'price': '600'},
    {'plan': '3.5GB / 7 Days', 'price': '1200'},
    {'plan': '10GB / 30 Days', 'price': '3000'},
    {'plan': '18.5GB / 30 Days', 'price': '5000'},
  ];

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onFormChanged);
    _customAmountController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    setState(() {}); // Rebuilds UI to evaluate form state
  }

  bool get _isFormValid {
    final bool hasPhone = _phoneController.text.trim().isNotEmpty;

    if (_selectedServiceIndex == 0) {
      // Airtime mode: requires phone AND custom amount field to be non-empty
      final bool hasAmount = _customAmountController.text.trim().isNotEmpty;
      return hasPhone && hasAmount;
    } else {
      // Data Bundle mode: requires phone AND selected data package
      return hasPhone && _selectedDataBundleIndex != -1;
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _customAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // Header Bar
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: topPadding + 8.0,
              bottom: 14.0,
              left: 16.0,
              right: 16.0,
            ),
            decoration: const BoxDecoration(color: Color(0xFFFFC727)),
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
                    'Buy Airtime & Data',
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

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Network Selection Section
                  const Text(
                    'SELECT NETWORK',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(_networks.length, (index) {
                        final net = _networks[index];
                        final isSelected = _selectedNetworkIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedNetworkIndex = index;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(int.parse(net['color']!)),
                                  shape: BoxShape.circle,
                                  border: isSelected
                                      ? Border.all(
                                          color: const Color(0xFFFFC727),
                                          width: 3,
                                        )
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    net['name']!,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Color(
                                        int.parse(net['textColor']!),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                net['name']!,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? const Color(0xFF0B192C)
                                      : const Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Service & Amount Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Service',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Service Toggle
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedServiceIndex = 0;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _selectedServiceIndex == 0
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: _selectedServiceIndex == 0
                                          ? [
                                              BoxShadow(
                                                color: Colors.black.withValues(
                                                  alpha: 0.04,
                                                ),
                                                blurRadius: 4,
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Airtime',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: _selectedServiceIndex == 0
                                              ? const Color(0xFF0B192C)
                                              : const Color(0xFF64748B),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedServiceIndex = 1;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _selectedServiceIndex == 1
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: _selectedServiceIndex == 1
                                          ? [
                                              BoxShadow(
                                                color: Colors.black.withValues(
                                                  alpha: 0.04,
                                                ),
                                                blurRadius: 4,
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Data Bundle',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: _selectedServiceIndex == 1
                                              ? const Color(0xFF0B192C)
                                              : const Color(0xFF64748B),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Phone Number
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Phone Number',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            GestureDetector(
                              onTap: widget.onContactsTap,
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.perm_contact_calendar_outlined,
                                    size: 14,
                                    color: Color(0xFFEAB308),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Contacts',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFEAB308),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B192C),
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Enter phone number',
                              hintStyle: TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Airtime Inputs vs Data Bundle Selection
                        if (_selectedServiceIndex == 0) ...[
                          const Text(
                            'Amount',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: List.generate(_presetAmounts.length, (
                              index,
                            ) {
                              final isSelected = _selectedAmountIndex == index;
                              final presetVal = _presetAmounts[index];

                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: index == _presetAmounts.length - 1
                                        ? 0
                                        : 8.0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedAmountIndex = index;
                                        // Overrides/replaces current value in the custom text field
                                        _customAmountController.text =
                                            presetVal;
                                        _customAmountController.selection =
                                            TextSelection.fromPosition(
                                              TextPosition(
                                                offset: presetVal.length,
                                              ),
                                            );
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFFFFFBEB)
                                            : const Color(0xFFF8FAFC),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: isSelected
                                              ? const Color(0xFFFFC727)
                                              : Colors.transparent,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '₦$presetVal',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF0B192C),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _customAmountController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF0B192C),
                              ),
                              onChanged: (val) {
                                // If manually typing a non-preset amount, clear preset selection outline
                                if (_selectedAmountIndex != -1 &&
                                    (_selectedAmountIndex >=
                                            _presetAmounts.length ||
                                        val !=
                                            _presetAmounts[_selectedAmountIndex])) {
                                  setState(() {
                                    _selectedAmountIndex = -1;
                                  });
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter custom amount',
                                hintStyle: TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 13,
                                ),
                                suffixIcon: Icon(
                                  Icons.content_paste_rounded,
                                  color: Color(0xFFEAB308),
                                  size: 18,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                        ] else ...[
                          const Text(
                            'Select Data Package',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: List.generate(_dataBundles.length, (
                              index,
                            ) {
                              final bundle = _dataBundles[index];
                              final isSelected =
                                  _selectedDataBundleIndex == index;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedDataBundleIndex = index;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFFFFFBEB)
                                          : const Color(0xFFF8FAFC),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFFFFC727)
                                            : Colors.transparent,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          bundle['plan']!,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF0B192C),
                                          ),
                                        ),
                                        Text(
                                          '₦${bundle['price']}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF0B192C),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isFormValid
                          ? () {
                              final data = {
                                'network':
                                    _networks[_selectedNetworkIndex]['name'],
                                'service': _selectedServiceIndex == 0
                                    ? 'Airtime'
                                    : 'Data',
                                'phone': _phoneController.text,
                                'amount': _selectedServiceIndex == 0
                                    ? _customAmountController.text
                                    : _dataBundles[_selectedDataBundleIndex]['price'],
                              };
                              if (widget.onContinueTap != null) {
                                widget.onContinueTap!(data);
                                return;
                              }
                              final double requestedAmount =
                                  double.tryParse(data['amount']!) ?? 0;
                              final bool hasSufficientBalance =
                                  requestedAmount <=
                                  AccountConstants.availableBalance;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TransactionStatusScreen(
                                    isSuccess: hasSufficientBalance,
                                    amount: data['amount']!,
                                    networkName: data['network']!,
                                    plan: data['service']!,
                                    recipient: data['phone']!,
                                    onPrimaryAction: () => hasSufficientBalance
                                        ? Navigator.popUntil(
                                            context,
                                            (route) => route.isFirst,
                                          )
                                        : Navigator.pop(context),
                                    onSecondaryAction: () => Navigator.popUntil(
                                      context,
                                      (route) => route.isFirst,
                                    ),
                                  ),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isFormValid
                            ? const Color(0xFFFFC727)
                            : const Color(0xFFE2E8F0),
                        foregroundColor: _isFormValid
                            ? const Color(0xFF0B192C)
                            : const Color(0xFF94A3B8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: _isFormValid
                                  ? Colors.black.withValues(alpha: 0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.receipt_rounded,
                              size: 16,
                              color: _isFormValid
                                  ? const Color(0xFF0B192C)
                                  : const Color(0xFF94A3B8),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: _isFormValid
                                ? const Color(0xFF0B192C)
                                : const Color(0xFF94A3B8),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
