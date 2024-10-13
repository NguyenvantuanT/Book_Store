import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.textInputAction,
    this.labelText,
    this.prefixIcon,
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.onFieldSubmitted,
    this.validator,
  });

  final String hintText;
  final BorderRadius borderRadius;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String? labelText;
  final Icon? prefixIcon;
  final Function(String)? onFieldSubmitted;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorHeight: 20.0,
      controller: controller,
      cursorColor: Colors.grey,
      textAlignVertical: const TextAlignVertical(y: 0.0),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: borderRadius),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.3),
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.2,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 40.0),
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 17.0),
        labelStyle: const TextStyle(color: Colors.black, fontSize: 18.0),
      ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: textInputAction,
    );
  }
}
