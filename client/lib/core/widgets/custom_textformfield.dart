import 'package:client/index.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscure;
  final bool readOnly;
  final VoidCallback? onTap;
  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscure = false,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value) => value!.trim().isEmpty ? '$hintText cannot be empty' : null,
      obscureText: obscure,
    );
  }
}
