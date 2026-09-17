import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class OTPScreen extends StatelessWidget {
  final String email;

  const OTPScreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: PinputExample(email: email),
        ),
      ),
    );
  }
}

class PinputExample extends StatefulWidget {
  final String email;

  const PinputExample({
    super.key,
    required this.email,
  });

  @override
  State<PinputExample> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputExample> {
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  Timer? _timer;
  int _secondsRemaining = 59;
  bool _canResend = false;
  bool _isPinComplete = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();

    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 59;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  Future<void> _handleResend() async {
    if (!_canResend) return;

    final success = await context
        .read<AuthProvider>()
        .resendRegistrationOtp(widget.email);
    if (!mounted) return;

    if (success) {
      pinController.clear();
      setState(() => _isPinComplete = false);
      _startTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A new verification code has been sent.')),
      );
    } else {
      final message = context.read<AuthProvider>().errorMessage ??
          'Unable to resend the verification code.';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  String _formatEmail(String email) {
    final atIndex = email.indexOf('@');
    if (atIndex > 1) {
      return '${email.substring(0, 2)}***${email.substring(atIndex)}';
    }
    return email;
  }

  @override
  void dispose() {
    if (kIsWeb) {
      BrowserContextMenu.enableContextMenu();
    }
    _timer?.cancel();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> _handleVerify() async {
    if (!_isPinComplete) return;

    final success = await context
        .read<AuthProvider>()
        .verifyRegistration(widget.email, pinController.text);
    if (!mounted) return;

    if (success) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      return;
    }

    final message = context.read<AuthProvider>().errorMessage ??
        'Invalid verification code. Please try again.';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    const navyColor = Color(0xFF0A192F);
    const primaryYellow = Color(0xFFFFCC00);
    const lightGreyBg = Color(0xFFF6F5F3);
    const borderColor = Color(0xFFE2E8F0);
    const infoBgColor = Color(0xFFF0F6FF);

    final defaultPinTheme = PinTheme(
      width: 48,
      height: 58,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: navyColor,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.5),
      ),
    );

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          const Text(
            'Verify Your Identity',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: navyColor,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Enter the 6-digit code sent to your email\n${_formatEmail(widget.email)}',
            style: TextStyle(
              fontSize: 15,
              color: navyColor.withAlpha(140),
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 36),
          Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Pinput(
                length: 6,
                controller: pinController,
                focusNode: focusNode,
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 8),
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onChanged: (value) {
                  setState(() {
                    _isPinComplete = value.length == 6;
                  });
                },
                onCompleted: (pin) {
                  setState(() {
                    _isPinComplete = true;
                  });
                },
                cursor: Container(
                  width: 2,
                  height: 24,
                  color: navyColor,
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: navyColor, width: 2),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: navyColor.withAlpha(120), width: 1.5),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: navyColor.withAlpha(160),
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      const TextSpan(text: 'Resend code in '),
                      TextSpan(
                        text: '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _handleResend,
                  child: Text(
                    'Resend',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _canResend ? navyColor : navyColor.withAlpha(120),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isPinComplete &&
                      context.watch<AuthProvider>().verificationState !=
                          ViewState.loading
                  ? _handleVerify
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isPinComplete ? primaryYellow : lightGreyBg,
                foregroundColor: _isPinComplete ? navyColor : navyColor.withAlpha(100),
                disabledBackgroundColor: lightGreyBg,
                disabledForegroundColor: navyColor.withAlpha(100),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                context.watch<AuthProvider>().verificationState ==
                        ViewState.loading
                    ? 'Verifying...'
                    : _isPinComplete
                    ? 'Verify & Continue'
                    : 'Enter Code',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: infoBgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_rounded,
                  color: Color(0xFF0066FF),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Didn't receive the code? Check your spam folder or try again.",
                    style: TextStyle(

                      fontSize: 13.5,
                      color: navyColor.withAlpha(200),
                      height: 1.35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}