import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final bool isPassword;
  final String? error;
  final bool isEmail;

  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.isPassword = false,
    this.error,
    this.isEmail = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscureText;

  @override
  void initState() {
    obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: Text(widget.label),
        errorText: widget.error,
        suffix: buildSuffixIcon(),
      ),
      keyboardType: keyboardType(),
      obscureText: widget.isPassword && obscureText,
      controller: widget.controller,
    );
  }

  TextInputType keyboardType() {
    if (widget.isEmail) {
      return TextInputType.emailAddress;
    } else if (widget.isPassword) {
      return TextInputType.visiblePassword;
    } else {
      return TextInputType.text;
    }
  }

  Widget? buildSuffixIcon() {
    Widget? suffixIcon;
    if (widget.isPassword && obscureText) {
      suffixIcon = IconButton(
        icon: const Icon(Icons.visibility_off),
        onPressed: () {
          setState(() {
            obscureText = false;
          });
        },
      );
    } else if (widget.isPassword && !obscureText) {
      suffixIcon = IconButton(
        icon: const Icon(Icons.visibility),
        onPressed: () {
          setState(() {
            obscureText = true;
          });
        },
      );
    }

    return suffixIcon;
  }
}
