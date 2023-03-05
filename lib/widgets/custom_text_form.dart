import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final String hint;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Icon? icon;
  final TextEditingController? textEditingController;
  final bool? obscure;
  final double? width;
  const CustomTextFormField({
    Key? key,
    required this.hint,
    this.icon,
    this.inputFormatters,
    this.validator,
    this.textEditingController,
    this.obscure,
    this.width,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscure;

  @override
  void initState() {
    _obscure = widget.obscure ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          controller: widget.textEditingController,
          obscureText: _obscure,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.icon,
            suffixIcon: widget.obscure != null && widget.obscure!
                ? IconButton(
                    icon: Icon(_obscure
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded),
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
