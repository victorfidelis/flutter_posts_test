import 'package:flutter/material.dart';
import 'package:flutter_posts_test/app/shared/widget/custom_text_error.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool isPassword;
  final String? error;

  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.isPassword = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: Text(label),
        errorText: error,
      ),
      obscureText: isPassword,
      controller: controller,
    );
  }
}
