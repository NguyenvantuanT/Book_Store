import 'package:book_app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AppBoxShadow {
  AppBoxShadow._();
  
  static const boxShadow = [
    BoxShadow(
      color: AppColors.shadow,
      offset: Offset(3.0, 3.0),
      blurRadius: 6.0,
    ),
  ];
}
