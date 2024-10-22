import 'package:book_app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AppSearchBox extends StatelessWidget {
  const AppSearchBox({super.key, this.onChanged, this.controller});

  final Function(String)? onChanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 45.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primaryC,
          border: Border.all(color: AppColors.primaryC,width: 0.8),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              offset:Offset(3.0, 3.0),
              blurRadius: 6.0
            ),
          ]
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
            border: InputBorder.none,
            hintText: "What are you looking for ?",
            hintStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.grey),
            suffixIcon: const Icon(Icons.search, color: AppColors.textColor,),
          ),
        ),
      ),
    );
  }
}