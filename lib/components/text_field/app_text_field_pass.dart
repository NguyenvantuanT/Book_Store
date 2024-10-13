import 'package:book_app/components/app_box_shadow.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextFieldPass extends StatefulWidget {
  const AppTextFieldPass({
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
  State<AppTextFieldPass> createState() => _AppTextFieldPassState();
}

class _AppTextFieldPassState extends State<AppTextFieldPass> {
  bool obscureText = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: 50.0,
          width: size.width,
          decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              color: AppColors.primaryC,
              boxShadow: AppBoxShadow.boxShadow),
        ),
        TextFormField(
          cursorHeight: 20.0,
          controller: widget.controller,
          obscureText: !obscureText,
          textAlignVertical: const TextAlignVertical(y: 0.0),
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            hintText: widget.hintText,
            labelText: widget.labelText,
            suffixIcon: GestureDetector(
              onTap: () => setState(() => obscureText = !obscureText),
              child: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.3),
                width: 1.2,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 40.0),
            border: OutlineInputBorder(borderRadius: widget.borderRadius),
            hintStyle: const TextStyle(color: AppColors.textColor, fontSize: 18.0),
            labelStyle: const TextStyle(color: AppColors.textColor, fontSize: 18.0),
          ),
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onFieldSubmitted: widget.onFieldSubmitted,
          textInputAction: widget.textInputAction,
        ),
      ],
    );
  }
}
