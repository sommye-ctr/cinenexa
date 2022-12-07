import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Icon? icon;
  final TextEditingController? textEditingController;
  final bool? obscure;
  const CustomTextFormField({
    Key? key,
    required this.hint,
    this.icon,
    this.inputFormatters,
    this.validator,
    this.textEditingController,
    this.obscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        inputFormatters: inputFormatters,
        validator: validator,
        controller: textEditingController,
        obscureText: obscure ?? false,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: icon,
        ),
      ),
    );
  }
}
