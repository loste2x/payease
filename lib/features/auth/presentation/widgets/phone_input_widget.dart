import 'package:flutter/material.dart';

class PhoneInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const PhoneInputWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      decoration: InputDecoration(
        counterText: '',
        prefixText: '+91 ',
        labelText: 'Mobile Number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
