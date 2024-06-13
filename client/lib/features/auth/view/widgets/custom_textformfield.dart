import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscure;
  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value) => value!.trim().isEmpty ? '$hintText cannot be empty' : null,
      obscureText: obscure,
    );
  }
}
