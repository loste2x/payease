import 'dart:async';
import 'package:flutter/material.dart';

class OtpTimerWidget extends StatefulWidget {
  const OtpTimerWidget({super.key});

  @override
  State<OtpTimerWidget> createState() => _OtpTimerWidgetState();
}

class _OtpTimerWidgetState extends State<OtpTimerWidget> {
  int seconds = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (seconds == 0) {
      return const Text(
        'You can request OTP again',
        style: TextStyle(color: Colors.green),
      );
    }

    return Text(
      'Resend OTP in ${seconds}s',
      style: const TextStyle(color: Colors.grey),
    );
  }
}
